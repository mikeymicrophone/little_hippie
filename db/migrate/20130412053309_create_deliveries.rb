class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.belongs_to :delivery_address
      t.belongs_to :print_purchase_order
      t.belongs_to :garment_purchase_order

      t.timestamps
    end
    add_index :deliveries, :delivery_address_id
    add_index :deliveries, :print_purchase_order_id
    add_index :deliveries, :garment_purchase_order_id
  end
end
