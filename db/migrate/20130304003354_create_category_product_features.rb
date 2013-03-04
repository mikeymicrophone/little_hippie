class CreateCategoryProductFeatures < ActiveRecord::Migration
  def change
    create_table :category_product_features do |t|
      t.belongs_to :category
      t.belongs_to :product_color
      t.integer :position

      t.timestamps
    end
    add_index :category_product_features, :category_id
    add_index :category_product_features, :product_color_id
  end
end
