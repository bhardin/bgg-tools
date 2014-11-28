class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  has_many :users_games
  has_many :games, through: :users_games

  def update_collection
    collection.each do |item|
      if item["status"].first["own"] == "1"
        self.games.create(:bgg_id => item["objectid"])
      end
    end
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

  private
  def bgg
    @bgg ||= BggApi.new
  end

  def collection
    @collection ||= bgg.collection( { :username => name } )["item"]
  end
end
