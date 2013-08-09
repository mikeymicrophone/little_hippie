class Like < ActiveRecord::Base
  belongs_to :favorite, :polymorphic => true
  belongs_to :product, :foreign_key => :favorite_id, :conditions => {'likes.favorite_type' => 'Product'}
  belongs_to :design, :foreign_key => :favorite_id, :conditions => {'likes.favorite_type' => 'Design'}
  
  belongs_to :customer
  belongs_to :cart
  attr_accessible :ip, :favorite_id, :favorite_type, :customer_id, :cart_id, :product, :customer, :cart
  
  # validate :find_duplicate_likes
  
  def find_duplicate_likes
    if customer
      if for_product?
        errors.add(:customer, 'already likes this product') if customer.liked_product_ids.include?(favorite_id)
      elsif for_design?
        errors.add(:customer, 'already likes this design') if customer.liked_design_ids.include?(favorite_id)
      end
    else
      if for_product?
        errors.add(:ip, 'already likes this product') if product.likes.find_by_ip(ip)
      elsif for_design?
        errors.add(:ip, 'already likes this design') if design.likes.find_by_ip(ip)
      end
    end
  end
  
  def for_product?
    favorite_type == 'Product'
  end
  
  def for_design?
    favorite_type == 'Design'
  end
end
