class Coupon < ActiveRecord::Base
  has_many :charges
  has_many :coupon_categories
  has_many :categories, :through => :coupon_categories
  has_many :coupon_products
  has_many :products, :through => :coupon_products
  has_many :coupon_designs
  has_many :designs, :through => :coupon_designs
  
  attr_accessible :amount, :code, :expiration_date, :lower_limit, :name, :percentage, :upper_limit, :valid_date, :free_shipping
  
  def valid_on_this_date?
    if valid_date.present?
      if expiration_date.present?
        (valid_date <= Time.now) && (Time.now <= expiration_date)
      else
        valid_date <= Time.now
      end
    elsif expiration_date.present?
      Time.now <= expiration_date
    else
      true
    end
  end
  
  def valid_for? product
    if (categories.empty? && products.empty?) && designs.empty?
      true
    elsif (categories & product.categories).present?
      true
    elsif products.include?(product)
      true
    elsif designs.include?(product.design)
      true
    else
      false
    end
  end
  
  def discount
    if amount.present?
      "$#{amount/100.0}"
    elsif percentage.present?
      "#{percentage}%"
    end
  end
end
