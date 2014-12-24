class Game < ActiveRecord::Base
  serialize :bgg_data, Hash
  has_many :users_games
  has_many :users, through: :users_games

  def self.create_from_bgg(id)
    Game.find_or_create_by(bgg_id: id)
    # GameUpdateWorker.perform_async(id)
  end

  def update_bgg_data
    GameUpdateWorker.perform_async(bgg_id)
  end

  def needs_updating?
    # No Name or Updated within 1 month
    name.nil? || self.updated_at < Time.zone.now - 1.month
  end

  def thumbnail
    bgg_data["thumbnail"].first
  end

  def image
    bgg_data["image"].first
  end

  def min_players
    bgg_data["minplayers"].first["value"]
  end

  def calculate_averages(marketplace_listings)
    @marketplace_listings = marketplace_listings[0]["listing"]

    price_hash.each do |name, data|
      case name
      when :new
        self.new_price = price_hash[:new][:average]
      when :likenew
        self.like_new_price = price_hash[:likenew][:average]
      when :verygood
        self.very_good_price = price_hash[:verygood][:average]
      when :good
        self.good_price = price_hash[:good][:average]
      when :acceptable
        self.acceptable_price = price_hash[:acceptable][:average]
      end
    end

    self.average_price = (price_hash.map { |x| x[1][:average] }.sum / price_hash.size.to_f).round(2)
    self.average_price = 0 if self.average_price.nan?

    self.save
  end

  # def marketplace_listings
  #   if bgg_data["marketplacelistings"] && bgg_data["marketplacelistings"][0] && bgg_data["marketplacelistings"][0]["listing"]
  #     bgg_data["marketplacelistings"][0]["listing"]
  #   else
  #     nil
  #   end
  # end

  private
    def price_hash
      @price_hash = {}

      return @price_hash unless @marketplace_listings

      @marketplace_listings.each do |listing|
        condition = listing["condition"][0]["value"]
        value = listing["price"][0]["value"]
        currency = listing["price"][0]["currency"]
        listdate = listing["listdate"][0]["value"]

        # Only use USD prices
        next unless currency == "USD"

        if @price_hash[condition.to_sym]
          @price_hash[condition.to_sym][:total] += value.to_f
          @price_hash[condition.to_sym][:count] += 1
        else
          @price_hash[condition.to_sym] = {}
          @price_hash[condition.to_sym][:total] = value.to_f
          @price_hash[condition.to_sym][:count] = 1
        end
      end

      # calculate and add averages
      @price_hash.each do |data|
        average = (data[1][:total] / data[1][:count].to_f).round(2)
        data[1][:average] = average
      end

      @price_hash
    end

end
