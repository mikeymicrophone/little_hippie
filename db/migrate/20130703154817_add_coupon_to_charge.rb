class AddCouponToCharge < ActiveRecord::Migration
  def change
    add_column :charges, :coupon_id, :integer
  end
end
