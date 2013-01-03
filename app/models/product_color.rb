class ProductColor < ActiveRecord::Base
  belongs_to :product
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  belongs_to :color
  has_many :inventories
  has_many :product_images
  attr_accessible :product_id, :color_id, :og_code
  validates_presence_of :product_id, :color_id
  validates_uniqueness_of :color_id, :scope => :product_id
  
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
