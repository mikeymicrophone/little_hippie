class ReceivedInventoryOnDelivery < ActiveRecord::Migration
  def up
    remove_column :received_inventories, :print_purchase_order_id
    remove_column :received_inventories, :garment_purchase_order_id
    remove_column :received_inventories, :quantity_id
    add_column :received_inventories, :delivery_id, :integer
  end

  def down
    remove_column :received_inventories, :delivery_id
    add_column :received_inventories, :quantity_id, :integer
    add_column :received_inventories, :garment_purchase_order_id, :integer
    add_column :received_inventories, :print_purchase_order_id, :integer
  end
end
