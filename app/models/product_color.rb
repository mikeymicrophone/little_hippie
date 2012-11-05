class ProductColor < ActiveRecord::Base
  belongs_to :product
  belongs_to :color
  attr_accessible :product_id, :color_id
  
  def name
    product.name + " in " + color.name
  end
end
