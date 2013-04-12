class CreateGarmentPurchaseOrders < ActiveRecord::Migration
  def change
    create_table :garment_purchase_orders do |t|
      t.belongs_to :supplier
      t.belongs_to :billing_address
      t.belongs_to :shipping_address

      t.timestamps
    end
    add_index :garment_purchase_orders, :supplier_id
    add_index :garment_purchase_orders, :billing_address_id
    add_index :garment_purchase_orders, :shipping_address_id
  end
end
