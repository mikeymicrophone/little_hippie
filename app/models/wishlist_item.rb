class WishlistItem < ActiveRecord::Base
  belongs_to :wishlist
  belongs_to :product_color
  belongs_to :size
  has_one :product, :through => :product_color
  has_one :color, :through => :product_color
  attr_accessible :wishlist_id, :product_color_id, :size_id, :wishlist, :product_color, :size
  validates_presence_of :product_color_id
  
  def name
    "#{product_color.name} in #{size.name}"
  end
end
