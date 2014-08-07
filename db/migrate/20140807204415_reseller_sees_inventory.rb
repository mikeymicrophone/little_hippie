class ResellerSeesInventory < ActiveRecord::Migration
  def up
    add_column :resellers, :sees_inventory, :boolean, :default => false
  end

  def down
    remove_column :resellers, :sees_inventory
  end
end
