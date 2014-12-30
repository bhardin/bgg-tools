class GameUpdateWorker
  include Sidekiq::Worker
  sidekiq_options :backtrace => true

  def perform(bgg_id)
    game = Game.find_by(bgg_id: bgg_id)

    if game.needs_updating?
      logger.info "Attempting update for #{game.id}"
      game.update_stuff
      logger.info "Successfully updated #{game.name}"
    end
  end
end