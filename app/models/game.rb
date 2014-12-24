class Game < ActiveRecord::Base
  serialize :poll, Hash
  has_many :users_games
  has_many :users, through: :users_games

  UPDATE_TIMEFRAME = 1.month

  def self.primary_name(name_array)
    name_array.each do |name|
      return name["value"] if name["type"] == "primary"
    end
  end

  def update_bgg_data
    GameUpdateWorker.perform_async(bgg_id)
  end

  def needs_updating?
    # No Name or Updated within 1 month
    name.nil? || self.updated_at < Time.zone.now - UPDATE_TIMEFRAME
  end

  def update_stuff(bgg_data)
    self.name           = Game.primary_name(bgg_data["name"])
    self.thumbnail      = bgg_data["thumbnail"].first
    self.image          = bgg_data["image"].first
    self.min_players    = bgg_data["minplayers"].first["value"]
    self.max_players    = bgg_data["maxplayers"].first["value"]
    self.description    = bgg_data["description"].first
    self.year_published = bgg_data["yearpublished"].first["value"]
    self.polls          = bgg_data["poll"]
    self.playing_time   = bgg_data["playingtime"].first["value"]
    self.minimum_age    = bgg_data["minage"].first["value"]

    self.save
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
