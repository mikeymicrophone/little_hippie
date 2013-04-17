class CreateInventorySnapshots < ActiveRecord::Migration
  def change
    create_table :inventory_snapshots do |t|
      t.belongs_to :garment
      t.integer :initial_amount
      t.integer :current_amount

      t.timestamps
    end
    add_index :inventory_snapshots, :garment_id
  end
end
