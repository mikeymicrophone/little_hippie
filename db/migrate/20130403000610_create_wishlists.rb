class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.belongs_to :customer
      t.string :name

      t.timestamps
    end
    add_index :wishlists, :customer_id
  end
end
