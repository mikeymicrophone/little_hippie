class CreateWholesaleOrders < ActiveRecord::Migration
  def change
    create_table :wholesale_orders do |t|
      t.integer :reseller_id
      t.integer :shipping_address_id
      t.string :status
      t.float :discount_percentage

      t.timestamps
    end
  end
end
