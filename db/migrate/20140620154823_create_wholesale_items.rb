class CreateWholesaleItems < ActiveRecord::Migration
  def change
    create_table :wholesale_items do |t|
      t.integer :wholesale_order_id
      t.integer :garment_id
      t.integer :quantity

      t.timestamps
    end
  end
end
