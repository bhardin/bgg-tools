class RemoveBggDataFromGame < ActiveRecord::Migration
  def change
  	remove_column :games, :bgg_data
  end
end
