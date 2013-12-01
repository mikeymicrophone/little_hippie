class Like < ActiveRecord::Base
  belongs_to :favorite, :polymorphic => true
  belongs_to :product, :foreign_key => :favorite_id, :conditions => {'likes.favorite_type' => 'Product'}
  belongs_to :design, :foreign_key => :favorite_id, :conditions => {'likes.favorite_type' => 'Design'}
  belongs_to :banner, :foreign_key => :favorite_id, :conditions => {'likes.favorite_type' => 'Banner'}
  belongs_to :bulletin, :foreign_key => :favorite_id, :conditions => {'likes.favorite_type' => 'Bulletin'}
  
  belongs_to :customer
  belongs_to :cart
  attr_accessible :ip, :favorite_id, :favorite_type, :customer_id, :cart_id, :customer, :cart, :facebook_user_id, :facebook_user_name
  
  validate :find_duplicate_likes
  
  def find_duplicate_likes
    if customer
      if for_product?
        errors.add(:customer, 'already likes this product') if customer.liked_product_ids.include?(favorite_id)
      elsif for_design?
        errors.add(:customer, 'already likes this design') if customer.liked_design_ids.include?(favorite_id)
      elsif for_banner?
        errors.add(:customer, 'already likes this banner') if customer.liked_banner_ids.include?(favorite_id)
      elsif for_bulletin?
        errors.add(:customer, 'already likes this bulletin') if customer.liked_bulletin_ids.include?(favorite_id)
      end
    elsif ip?
      if for_product?
        errors.add(:ip, 'already likes this product') if Product.find(favorite_id).likes.find_by_ip(ip)
      elsif for_design?
        errors.add(:ip, 'already likes this design') if Design.find(favorite_id).likes.find_by_ip(ip)
      elsif for_banner?
        errors.add(:ip, 'already likes this banner') if Banner.find(favorite_id).likes.find_by_ip(ip)
      elsif for_bulletin?
        errors.add(:ip, 'already likes this bulletin') if Bulletin.find(favorite_id).likes.find_by_ip(ip)
      end
    end
  end
  
  def for_product?
    favorite_type == 'Product'
  end
  
  def for_design?
    favorite_type == 'Design'
  end
  
  def for_banner?
    favorite_type == 'Banner'
  end
  
  def for_bulletin?
    favorite_type == 'Bulletin'
  end
end
