class ResellerHasStripeAndPrivileges < ActiveRecord::Migration
  def up
    add_column :resellers, :stripe_customer_id, :string
    add_column :resellers, :authorized, :boolean, :default => false
  end

  def down
    remove_column :resellers, :stripe_customer_id
    remove_column :resellers, :authorized
  end
end
