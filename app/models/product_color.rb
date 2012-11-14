class ProductColor < ActiveRecord::Base
  belongs_to :product
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  belongs_to :color
  has_many :inventories
  has_many :product_images
  attr_accessible :product_id, :color_id, :og_code
  
  def name
    product.name + " in " + color.name
  end
  
  def image
    product_images.first.andand.image
  end
  
  def in_inventory
    inventories.sum(:amount)
  end
end
