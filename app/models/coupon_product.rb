class CouponProduct < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :product
  attr_accessible :coupon_id, :product_id
  validates_presence_of :coupon_id, :product_id
end
