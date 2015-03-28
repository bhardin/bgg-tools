class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  # GET /games/1
  # GET /games/1.json
  def show
    @historical_prices = @game.historical_prices
  end

  # POST /games/search?name=some game name
  def search
    @games = Game.where('name LIKE ?', "%#{params[:name]}%")
    render :index
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:string)
    end
end
