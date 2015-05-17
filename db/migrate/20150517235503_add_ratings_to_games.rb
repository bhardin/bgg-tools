class AddRatingsToGames < ActiveRecord::Migration
  def change
    add_column :games, :bayesian_average, :float
    add_column :games, :average_rating, :float
  end
end
