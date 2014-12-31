require 'array'

class Game < ActiveRecord::Base
  serialize :poll, Hash
  has_many :users_games
  has_many :users, through: :users_games
  has_many :historical_prices

  attr_accessor :marketplace_history

  UPDATE_TIMEFRAME = 1.month

  def self.primary_name(name_array)
    name_array.each do |name|
      return name["value"] if name["type"] == "primary"
    end
  end

  def historical_price_array
    self.historical_prices.select {|x| x.currency == "USD"}.map {|x| x.price}
  end

  def update_bgg_data
    game_update_worker.perform_async(bgg_id) if self.needs_updating?
  end

  def needs_updating?
    # No Name or Updated within 1 month
    name.nil? || self.updated_at < Time.zone.now - UPDATE_TIMEFRAME
  end

  def update_stuff
    raise "No BGG_ID for this game" if self.bgg_id.nil?

    bgg_api = BggApi.new
    bgg_data = bgg_api.thing(id: bgg_id,
                             pricehistory: 1)["item"].first

    self.name           = Game.primary_name(bgg_data["name"])
    self.thumbnail      = bgg_data["thumbnail"].first if bgg_data["thumbnail"]
    self.image          = bgg_data["image"].first if bgg_data["image"]
    self.min_players    = bgg_data["minplayers"].first["value"]
    self.max_players    = bgg_data["maxplayers"].first["value"]
    self.description    = bgg_data["description"].first
    self.year_published = bgg_data["yearpublished"].first["value"]
    self.polls          = bgg_data["poll"]
    self.playing_time   = bgg_data["playingtime"].first["value"]
    self.minimum_age    = bgg_data["minage"].first["value"]

    if bgg_data["marketplacehistory"] &&
       bgg_data["marketplacehistory"][0] &&
       bgg_data["marketplacehistory"][0]["listing"]
      self.marketplace_history = bgg_data["marketplacehistory"][0]["listing"]
    end

    self.store_marketplace_data
    self.save

    # Qwirky: I have to reload the object, to pull the new data from the DB.
    #         If I don't save the previous line, all the other stuff (like the
    #         name) is forgotten.
    reload
    self.calculate_prices

    self.save
  end

  # private
    def calculate_prices
      # if self.historical_prices
        self.mean_price = self.historical_price_array.mean.round(2)
        self.median_price = self.historical_price_array.median.round(2)
        self.save
      # end
    end

    def store_marketplace_data
      return unless marketplace_history

      self.historical_prices.destroy_all

      marketplace_history.each do |listing|
        condition = listing["condition"][0]["value"]
        value     = listing["price"][0]["value"]
        currency  = listing["price"][0]["currency"]
        listdate  = listing["listdate"][0]["value"]
        sale_date  = listing["saledate"][0]["value"]

        hp = HistoricalPrice.new(
          game_id: self.id,
          date_sold: sale_date,
          price: value,
          currency: currency,
          condition: condition
        )

        hp.save
      end
    end

  private
    def game_update_worker
      GameUpdateWorker
    end
end
