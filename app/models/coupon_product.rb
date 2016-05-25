class CouponProduct < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :product
  attr_accessible :coupon_id, :product_id, :valid_date, :expiration_date
  validates_presence_of :coupon_id, :product_id
  scope :recent, order('created_at desc')
  scope :began, lambda { where('valid_date is null or valid_date < ?', Time.now) }
  scope :not_ended, lambda { where('expiration_date is null or expiration_date > ?', Time.now)}
  scope :current, lambda { began.not_ended }
end
