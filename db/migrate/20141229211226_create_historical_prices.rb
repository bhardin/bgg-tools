class CreateHistoricalPrices < ActiveRecord::Migration
  def change
    create_table :historical_prices do |t|
      t.integer :game_id
      t.date :date_sold
      t.float :price
      t.string :currency
      t.string :condition
      t.string :link

      t.timestamps
    end
  end
end
