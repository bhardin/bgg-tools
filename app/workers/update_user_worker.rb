class UpdateUserWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :quick, :backtrace => true

  def perform(user_id)
    user = User.find(user_id)

    if user.needs_updating?
      return if user.collection.nil?

      user.games.delete_all # Remove old associations.

      user.collection.each do |item|
        if item["status"].first["own"] == "1"
          game = Game.find_or_create_by(:bgg_id => item['objectid'])
          user.games << game
          game.update_bgg_data # This will kick off a worker.
        end
      end

      user.updated_at = Time.now
      user.save
    else
      logger.info "User #{user.name} has already been updated."
    end
  end
end