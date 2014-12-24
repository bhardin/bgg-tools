class MakingBggIdUniqueOnGames < ActiveRecord::Migration
  def change
    add_index :games, :bgg_id, :unique => true
  end
end
