class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_color
  has_one :color, :through => :product_color
  has_one :product, :through => :product_color
  has_one :body_style, :through => :product
  belongs_to :size
  belongs_to :garment
  attr_accessible :product_color_id, :size_id, :quantity, :gift_wrap
  validates_presence_of :cart_id, :product_color_id, :size_id
  
  before_create :set_default_quantity
  
  delegate :css_hex_code, :to => :color
  
  scope :blanket, joins(:body_style).where('body_styles.code' => 'RUG')
  
  def name
    "#{product_color.andand.name} in #{size.andand.name}"
  end
  
  def cost
    (product.andand.size_price(size).to_f + (gift_wrap? ? 3.5 : 0)) * quantity
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
  
  def was_purchased?
    cart.charges.first.andand.completed?
  end
end
