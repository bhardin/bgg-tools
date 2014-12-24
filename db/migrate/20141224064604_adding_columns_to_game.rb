class AddingColumnsToGame < ActiveRecord::Migration
  def change
		add_column :games, :thumbnail, :string
		add_column :games, :image, :string
		add_column :games, :description, :text
		add_column :games, :min_players, :integer
		add_column :games, :max_players, :integer
		add_column :games, :year_published, :integer
		add_column :games, :minimum_age, :integer
		add_column :games, :playing_time, :integer
  	add_column :games, :polls, :text
  end
end
