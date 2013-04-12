class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.belongs_to :garment_purchase_order
      t.belongs_to :print_purchase_order
      t.integer :purchased
      t.belongs_to :unit_price
      t.belongs_to :source_stock

      t.timestamps
    end
    add_index :quantities, :garment_purchase_order_id
    add_index :quantities, :print_purchase_order_id
    add_index :quantities, :unit_price_id
  end
end
