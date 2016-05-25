class CouponCategory < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :category
  attr_accessible :coupon_id, :category_id
  scope :recent, order('created_at desc')
end
