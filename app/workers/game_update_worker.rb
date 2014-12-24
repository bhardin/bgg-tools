class GameUpdateWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 3 # Only five retries and then to the Dead Job Queue

  def perform(bgg_id)
    game = Game.find_by(bgg_id: bgg_id)

    if game.needs_updating?
      logger.info "Attempting update for #{game.id}"

    	bgg_api = BggApi.new
    	bgg_data = bgg_api.thing(:id => bgg_id,
                               :marketplace => 1)["item"].first

      game.name = bgg_data["name"].first["value"]

      if bgg_data["marketplacelistings"]
        game.calculate_averages(bgg_data["marketplacelistings"])
      end

      game.save

      logger.info "Updated #{game.name}"
    end
  end
end