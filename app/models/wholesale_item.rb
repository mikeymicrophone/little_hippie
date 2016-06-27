class WholesaleItem < ActiveRecord::Base
  attr_accessible :garment_id, :quantity, :wholesale_order_id, :garment, :wholesale_order
  validates_presence_of :garment_id, :wholesale_order_id, :quantity
  belongs_to :garment
  belongs_to :wholesale_order
  has_one :design, :through => :garment
  has_one :body_style, :through => :garment
  has_one :body_style_size, :through => :garment
  has_one :color, :through => :garment
  delegate :product_color, :to => :garment
  delegate :product, :to => :garment
  delegate :name, :to => :garment
  delegate :inventory_amount, :to => :garment
  has_one :size, :through => :garment
  scope :inventory_order, joins(:design, :body_style, :color, :size).order('designs.number', 'body_styles.position', 'colors.position', 'sizes.position')
  
  delegate :name, :to => :garment
  
  def price
    quantity * garment.wholesale_price
  end
  
  def discounted_price
    price * ((100.0 - wholesale_order.discount_percentage)/100.0)
  end
  
  def dollar_price
    discounted_price / 100.0
  end
  
  def unit_price
    garment.wholesale_price / 100.0
  end
  
  def product_code
    garment.code
  end
  
  def decrement_inventory!
    garment.decrement_inventory! quantity
  end
end
