class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.belongs_to :product_color
      t.belongs_to :size
      t.integer :amount

      t.timestamps
    end
    add_index :inventories, :product_color_id
    add_index :inventories, :size_id
  end
end
