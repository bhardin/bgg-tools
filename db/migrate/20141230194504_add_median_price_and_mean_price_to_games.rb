class AddMedianPriceAndMeanPriceToGames < ActiveRecord::Migration
  def change
    add_column :games, :median_price, :float
    add_column :games, :mean_price, :float
  end
end
