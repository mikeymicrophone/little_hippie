class CreateReceivedInventories < ActiveRecord::Migration
  def change
    create_table :received_inventories do |t|
      t.belongs_to :print_purchase_order
      t.belongs_to :garment_purchase_order
      t.belongs_to :quantity
      t.integer :amount_delayed
      t.integer :amount_cancelled
      t.datetime :date_received
      t.belongs_to :first_snapshot

      t.timestamps
    end
    add_index :received_inventories, :print_purchase_order_id
    add_index :received_inventories, :garment_purchase_order_id
    add_index :received_inventories, :quantity_id
    add_index :received_inventories, :first_snapshot_id
  end
end
