class Like < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer
  belongs_to :cart
  attr_accessible :ip, :product_id, :customer_id, :cart_id, :product, :customer, :cart
end
