class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.belongs_to :product
      t.belongs_to :customer
      t.string :ip
      t.belongs_to :cart

      t.timestamps
    end
    add_index :likes, :product_id
    add_index :likes, :customer_id
    add_index :likes, :cart_id
  end
end
