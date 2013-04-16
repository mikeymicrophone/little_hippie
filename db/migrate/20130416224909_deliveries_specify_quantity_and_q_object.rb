class DeliveriesSpecifyQuantityAndQObject < ActiveRecord::Migration
  def up
    remove_column :deliveries, :garment_purchase_order_id
    remove_column :deliveries, :print_purchase_order_id
    add_column :deliveries, :quantity_id, :integer
    add_column :deliveries, :quantity_delivered, :integer
    add_column :deliveries, :date_delivered, :datetime
  end

  def down
    remove_column :deliveries, :quantity_delivered
    remove_column :deliveries, :quantity_id
    remove_column :deliveries, :date_delivered
    add_column :deliveries, :print_purchase_order_id, :integer
    add_column :deliveries, :garment_purchase_order_id, :integer
  end
end
