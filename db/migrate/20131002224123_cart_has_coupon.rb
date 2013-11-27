class CartHasCoupon < ActiveRecord::Migration
  def up
    add_column :carts, :coupon_id, :integer
  end

  def down
    remove_column :carts, :coupon_id
  end
end
