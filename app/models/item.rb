class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product_color
  belongs_to :size
  attr_accessible :product_color_id, :size_id
end
