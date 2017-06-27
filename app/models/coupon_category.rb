class CouponCategory < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :category
  attr_accessible :coupon_id, :category_id, :valid_date, :expiration_date
  scope :recent, lambda { order('created_at desc') }
  scope :began, lambda { where('valid_date is null or valid_date < ?', Time.now) }
  scope :not_ended, lambda { where('expiration_date is null or expiration_date > ?', Time.now)}
  scope :current, lambda { began.not_ended }
end
