class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_color
  has_one :color, :through => :product_color
  has_one :product, :through => :product_color
  belongs_to :size
  attr_accessible :product_color_id, :size_id, :quantity, :gift_wrap
  validates_presence_of :cart_id, :product_color_id, :size_id
  
  before_create :set_default_quantity
  
  delegate :css_hex_code, :to => :color
  
  def name
    "#{product_color.name} in #{size.name}"
  end
  
  def cost
    product.dollar_price * quantity + (gift_wrap? ? 3.75 : 0)
  end
  
  def set_default_quantity
    self.quantity ||= 1
  end
end
