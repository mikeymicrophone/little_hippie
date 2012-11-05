class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.belongs_to :product
      t.belongs_to :color

      t.timestamps
    end
    add_index :product_colors, :product_id
    add_index :product_colors, :color_id
  end
end
