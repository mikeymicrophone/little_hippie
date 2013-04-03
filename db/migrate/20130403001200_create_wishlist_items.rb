class CreateWishlistItems < ActiveRecord::Migration
  def change
    create_table :wishlist_items do |t|
      t.belongs_to :wishlist
      t.belongs_to :product_color
      t.belongs_to :size

      t.timestamps
    end
    add_index :wishlist_items, :wishlist_id
    add_index :wishlist_items, :product_color_id
    add_index :wishlist_items, :size_id
  end
end
