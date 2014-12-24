class GamePriceWorker
  include Sidekiq::Worker

  def perform(id)
    game = Game.find_by(id: id)
    game.calculate_averages
  end
end