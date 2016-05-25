class CouponDateValidity < ActiveRecord::Migration
  def up
    add_column :coupon_categories, :valid_date, :datetime
    add_column :coupon_categories, :expiration_date, :datetime
    
    add_column :coupon_designs, :valid_date, :datetime
    add_column :coupon_designs, :expiration_date, :datetime
    
    add_column :coupon_products, :valid_date, :datetime
    add_column :coupon_products, :expiration_date, :datetime
  end

  def down
    remove_column :coupon_categories, :valid_date
    remove_column :coupon_categories, :expiration_date
    
    remove_column :coupon_designs, :valid_date
    remove_column :coupon_designs, :expiration_date
    
    remove_column :coupon_products, :valid_date
    remove_column :coupon_products, :expiration_date
  end
end
