class ResellerHasDeliveryAddress < ActiveRecord::Migration
  def up
    add_column :resellers, :delivery_address_id, :integer
  end

  def down
    remove_column :resellers, :delivery_address_id
  end
end
