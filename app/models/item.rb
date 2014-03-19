class Item < ActiveRecord::Base
  belongs_to :cart
  has_many :charges, :through => :cart
  belongs_to :product_color
  has_one :color, :through => :product_color
  has_one :product, :through => :product_color
  has_one :body_style, :through => :product
  has_many :charges, :through => :cart
  has_many :coupons, :through => :charges
  belongs_to :size
  belongs_to :garment
  attr_accessible :product_color_id, :size_id, :quantity, :gift_wrap
  validates_presence_of :cart_id, :product_color_id, :size_id
  
  delegate :css_hex_code, :to => :color
  
  scope :blanket, joins(:body_style).where('body_styles.code' => 'RUG')
  scope :purchased, joins(:cart).merge(Cart.complete)
  scope :since, lambda { |date| joins(:charges).where('charges.created_at > ?', date).merge(Charge.complete) }
  scope :before, lambda { |date| joins(:charges).where('charges.created_at < ?', date).merge(Charge.complete) }
  # scope :popular, group(:product_color_id).select('items.*, sum(items.quantity) as purchases')
  
  def name
    "#{product_color.andand.name} in #{size.andand.name}"
  end
  
  def is_on_sale?
    product.is_on_sale? || garment.is_on_sale?
  end

  def sale
    is_on_sale?.andand.sale
  end
  
  def cost
    product.andand.size_price(size).to_f * quantity
  end
  
  def sale_discount
    if sale.andand.amount.present?
      cart.sale = true
      quantity * (sale.amount/100.0)
    elsif sale.andand.percentage.present?
      cart.sale = true
      cost * (sale.percentage/100.0)
    else
      0
    end
  end
  
  def final_cost
    cost - sale_discount
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
