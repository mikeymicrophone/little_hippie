class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_color
  has_one :product, :through => :product_color
  belongs_to :size
  attr_accessible :product_color_id, :size_id
  validates_presence_of :cart_id, :product_color_id, :size_id
  
  def name
    "#{product_color.name} in #{size.name}"
  end
end
