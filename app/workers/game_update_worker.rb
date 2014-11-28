class GameUpdateWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 15 # Only five retries and then to the Dead Job Queue

  def perform(bgg_game_id)
    bgg_api = BggApi.new
    bgg_data = bgg_api.thing(:id => bgg_game_id,
                             :marketplace => 1)["item"].first

    game = Game.find_or_create_by(bgg_id: bgg_game_id)
    game.convert_bggdata(bgg_data)
  end
end