class Coupon < ActiveRecord::Base
  has_many :charges
  has_many :coupon_categories
  has_many :categories, :through => :coupon_categories
  
  attr_accessible :amount, :code, :expiration_date, :lower_limit, :name, :percentage, :upper_limit, :valid_date
  
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
end
