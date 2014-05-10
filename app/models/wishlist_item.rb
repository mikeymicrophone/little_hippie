class WishlistItem < ActiveRecord::Base
  belongs_to :wishlist
  belongs_to :product_color
  belongs_to :size
  has_one :product, :through => :product_color
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  has_one :color, :through => :product_color
  attr_accessible :wishlist_id, :product_color_id, :size_id, :wishlist, :product_color, :size
  validates_presence_of :product_color_id
  scope :inventory_order, lambda { joins(:product).merge(Product.inventory_order) }
  scope :body_style_order, lambda { joins(:body_style).merge(BodyStyle.ordered) }
  
  def name
    "#{product_color.name} in #{size.name}"
  end
end
