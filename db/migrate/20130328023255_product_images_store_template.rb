class ProductImagesStoreTemplate < ActiveRecord::Migration
  def up
    add_column :product_images, :image_position_template_id, :integer
  end

  def down
    remove_column :product_images, :image_position_template_id
  end
end
