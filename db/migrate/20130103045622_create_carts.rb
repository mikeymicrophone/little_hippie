class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.belongs_to :customer
      t.integer :status

      t.timestamps
    end
    add_index :carts, :customer_id
  end
end
