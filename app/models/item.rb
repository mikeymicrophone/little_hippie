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
  
  scope :blanket, lambda { joins(:body_style).where('body_styles.code' => 'RUG') }
  scope :purchased, lambda { joins(:cart).merge(Cart.complete) }
  scope :since, lambda { |date| joins(:charges).where('charges.created_at > ?', date).merge(Charge.complete) }
  scope :before, lambda { |date| joins(:charges).where('charges.created_at < ?', date).merge(Charge.complete) }
  scope :pertinent_to_old_glory, lambda { joins(:product).merge(Product.shipped_by(1)) }
  # scope :popular, lambda { group(:product_color_id).select('items.*, sum(items.quantity) as purchases') }
  scope :mww, lambda { joins(:product_color).merge(ProductColor.mww) }
  
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
  
  def net_profit
    if final_price
      final_price - old_glory_cost
    else
      final_cost - old_glory_cost
    end
  end
  
  OLD_GLORY_DISCOUNT = 0.10
  def old_glory_cost
    product.garment_cost(size, color).to_f * (1.0 - OLD_GLORY_DISCOUNT)
  end
  
  def set_default_quantity
    self.quantity ||= 1
  end
  
  def body_style_size
    product.body_style_sizes.where(:size_id => size_id).first
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
  
  def to_mww_xml builder, index
    builder.LineItem do
      builder.LineNumber(index + 1)
      builder.ProductCode(garment.mww_code)
      builder.ProductUPC(nil)
      builder.ItemDescription(body_style.name)
      builder.Quantity(quantity)
      builder.ItemSSCC(nil)
      builder.FileList do
        builder.Source(garment.fabric_photo.url)
      end
    end
  end
end
