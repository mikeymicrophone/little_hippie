class CouponsHaveLimitedUses < ActiveRecord::Migration
  def up
  	add_column :coupons, :maximum_uses, :integer
  	add_column :coupons, :uses_remaining, :integer
  end

  def down
  	remove_column :coupons, :maximum_uses
  	remove_column :coupons, :uses_remaining
  end
end
