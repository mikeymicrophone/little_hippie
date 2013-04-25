class InventorySnapshotCurrent < ActiveRecord::Migration
  def up
    add_column :inventory_snapshots, :current, :boolean
  end

  def down
    remove_column :inventory_snapshots, :current
  end
end
