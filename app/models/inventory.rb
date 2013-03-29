class Inventory < ActiveRecord::Base
  belongs_to :product_color
  has_one :product, :through => :product_color
  has_one :color, :through => :product_color
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  belongs_to :size
  attr_accessible :amount, :product_color_id, :size_id
  validates_presence_of :product_color_id, :size_id
  
  def name
    product_color.name + "(" + size.name + ")"
  end
  
  def art
    design.art
  end
  
  def price
    product.price
  end
  
  def price_in_dollars
    price/100
  end
end
