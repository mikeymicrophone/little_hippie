class CartIncludesReferralType < ActiveRecord::Migration
  def up
    add_column :carts, :referral_type, :string
  end

  def down
    remove_column :carts, :referral_type
  end
end
