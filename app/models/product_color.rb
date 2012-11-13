class ProductColor < ActiveRecord::Base
  belongs_to :product
  belongs_to :color
  has_many :product_images
  attr_accessible :product_id, :color_id
  
  def name
    product.name + " in " + color.name
  end
  
  def image
    product_images.first.andand.image
  end
end
