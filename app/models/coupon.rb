class Coupon < ActiveRecord::Base
  has_many :charges
  has_many :coupon_categories
  has_many :categories, :through => :coupon_categories
  has_many :coupon_products
  has_many :products, :through => :coupon_products
  has_many :coupon_designs
  has_many :designs, :through => :coupon_designs
  
  attr_accessible :amount, :code, :expiration_date, :lower_limit, :name, :percentage, :upper_limit, :valid_date, :free_shipping, :maximum_uses, :uses_remaining

  before_create :set_remaining_uses
  
  scope :recent, lambda { order('created_at desc') }
  
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
    elsif (coupon_categories.current.map(&:category) & product.categories).present?
      true
    elsif coupon_products.current.map(&:product).include?(product)
      true
    elsif coupon_designs.current.map(&:design).include?(product.design)
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

  def set_remaining_uses
    self.uses_remaining = maximum_uses
  end

  def decrement_uses_remaining!
    if uses_remaining.present? && uses_remaining > 0
      update_attribute :uses_remaining, uses_remaining - 1
    end
  end

  def used_up?
    maximum_uses.present? && uses_remaining == 0
  end
end
