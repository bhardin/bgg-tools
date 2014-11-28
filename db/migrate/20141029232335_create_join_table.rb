class CreateJoinTable < ActiveRecord::Migration
  def change
  	create_join_table :games, :users, {:table_name => :users_games} do |t|
  		t.index :game_id
  		t.index :user_id
		end
  end
end
