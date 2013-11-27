class CouponDesign < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :design
  attr_accessible :coupon_id, :design_id
end
