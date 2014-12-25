class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  has_many :users_games
  has_many :games, through: :users_games

  UPDATE_TIMEFRAME = 15.days

  def update_collection
    UpdateUserWorker.perform_async(self.id)
  end

  def needs_updating?
    games.empty? || self.updated_at < Time.zone.now - UPDATE_TIMEFRAME
  end

  def collection_value
    (games.map { |g| g.average_price.to_f }.sum).round(2)
  end

  def average_game_price
    (collection_value / (games.length - games_without_prices)).round(2)
  end

  def games_without_prices
    games.map {|x| x.average_price.to_f }.count(0)
  end

  def collection
    @collection ||= bgg.collection( { :username => name } )["item"]
  end

  private
    def bgg
      @bgg ||= BggApi.new
    end
end
