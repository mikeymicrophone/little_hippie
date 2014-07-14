class WholesaleItem < ActiveRecord::Base
  attr_accessible :garment_id, :quantity, :wholesale_order_id
  validates_presence_of :garment_id, :wholesale_order_id, :quantity
  belongs_to :garment
  belongs_to :wholesale_order
  has_one :design, :through => :garment
  has_one :body_style, :through => :garment
  has_one :body_style_size, :through => :garment
  has_one :color, :through => :garment
  delegate :product_color, :to => :garment
  has_one :size, :through => :garment
  scope :inventory_order, joins(:design, :body_style, :color, :size).order('designs.number', 'body_styles.position', 'colors.position', 'sizes.position')
  
  def price
    quantity * garment.wholesale_price
  end
  
  def dollar_price
    price / 100.0
  end
  
  def unit_price
    garment.wholesale_price / 100.0
  end
  
  def product_code
    garment.code
  end
end
