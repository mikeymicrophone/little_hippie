class CreateUnitPrices < ActiveRecord::Migration
  def change
    create_table :unit_prices do |t|
      t.belongs_to :stock
      t.belongs_to :garment
      t.integer :price

      t.timestamps
    end
    add_index :unit_prices, :stock_id
    add_index :unit_prices, :garment_id
  end
end
