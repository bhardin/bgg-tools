class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  has_many :users_games
  has_many :games, through: :users_games

  UPDATE_TIMEFRAME = 15.days

  def update_collection
    UpdateUserWorker.perform_async(self.id)
  end

  def mark_as_needs_updating
    games.delete_all
  end

  def needs_updating?
    games.empty? || self.updated_at < Time.zone.now - UPDATE_TIMEFRAME
  end

  def mean_collection_value
    games.select {|x| !x.mean_price.nil? }.map {|x| x.mean_price}.sum.round(2)
  end

  def median_collection_value
    games.select {|x| !x.median_price.nil? }.map {|x| x.median_price}.sum.round(2)
  end

  def median_game_price
    (median_collection_value / (games.length - games_without_prices)).round(2)
  end

  def mean_game_price
    (mean_collection_value / (games.length - games_without_prices)).round(2)
  end

  def games_without_prices
    games.map {|x| x.median_price}.count(0)
  end

  def collection
    @collection ||= bgg.collection( { :username => name } )["item"]
  end

  private
    def bgg
      @bgg ||= BggApi.new
    end
end
