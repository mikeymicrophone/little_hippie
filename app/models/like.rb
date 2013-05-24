class Like < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer
  belongs_to :cart
  attr_accessible :ip, :product_id, :customer_id, :cart_id, :product, :customer, :cart
  
  validate :find_duplicate_likes
  
  def find_duplicate_likes
    if customer
      errors.add(:customer, 'already likes this product') if customer.liked_product_ids.include?(product_id)
    else
      errors.add(:ip, 'already likes this product') if product.likes.find_by_ip(ip)
    end
  end
end
