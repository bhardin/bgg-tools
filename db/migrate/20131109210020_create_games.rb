class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :bgg_data
      t.integer :bgg_id
      t.string :new_price
      t.string :like_new_price
      t.string :very_good_price
      t.string :good_price
      t.string :acceptable_price
      t.string :average_price

      t.timestamps
    end
  end
end
