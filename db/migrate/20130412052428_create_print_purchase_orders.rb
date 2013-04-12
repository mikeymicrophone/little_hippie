class CreatePrintPurchaseOrders < ActiveRecord::Migration
  def change
    create_table :print_purchase_orders do |t|
      t.belongs_to :supplier
      t.belongs_to :billing_address
      t.belongs_to :garment_purchase_order

      t.timestamps
    end
    add_index :print_purchase_orders, :supplier_id
    add_index :print_purchase_orders, :billing_address_id
    add_index :print_purchase_orders, :garment_purchase_order_id
  end
end
