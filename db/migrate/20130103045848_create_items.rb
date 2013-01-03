class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :cart
      t.belongs_to :product_color
      t.belongs_to :size

      t.timestamps
    end
    add_index :items, :cart_id
    add_index :items, :product_color_id
    add_index :items, :size_id
  end
end
