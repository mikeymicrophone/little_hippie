class FreeShippingCoupon < ActiveRecord::Migration
  def up
    add_column :coupons, :free_shipping, :boolean
  end

  def down
    remove_column :coupons, :free_shipping
  end
end
