class ProductImage < ActiveRecord::Base
  belongs_to :product_color
  attr_accessible :image, :product_color_id
  mount_uploader :image, ProductImageUploader
end
