class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_color
  has_one :color, :through => :product_color
  has_one :product, :through => :product_color
  belongs_to :size
  belongs_to :garment
  attr_accessible :product_color_id, :size_id, :quantity, :gift_wrap
  validates_presence_of :cart_id, :product_color_id, :size_id
  
  before_create :set_default_quantity
  
  delegate :css_hex_code, :to => :color
  
  def name
    "#{product_color.name} in #{size.name}"
  end
  
  def cost
    (product.size_price(size) + (gift_wrap? ? 3.5 : 0)) * quantity
  end
  
  def set_default_quantity
    self.quantity ||= 1
  end
  
  def body_style_size
    product.body_style.body_style_sizes.where(:size_id => size_id).first
  end
  
  def design
    product.design
  end
  
  def is_in_stock?
    garment.stashed_inventories.any? || garment.inventory.current_amount > quantity
  end
end
