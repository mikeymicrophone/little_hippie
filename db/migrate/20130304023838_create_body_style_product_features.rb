class CreateBodyStyleProductFeatures < ActiveRecord::Migration
  def change
    create_table :body_style_product_features do |t|
      t.belongs_to :body_style
      t.belongs_to :product_color
      t.integer :position

      t.timestamps
    end
    add_index :body_style_product_features, :body_style_id
    add_index :body_style_product_features, :product_color_id
  end
end
