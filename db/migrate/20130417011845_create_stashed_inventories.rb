class CreateStashedInventories < ActiveRecord::Migration
  def change
    create_table :stashed_inventories do |t|
      t.belongs_to :garment
      t.belongs_to :delivery_address

      t.timestamps
    end
    add_index :stashed_inventories, :garment_id
    add_index :stashed_inventories, :delivery_address_id
    
    add_column :delivery_addresses, :is_stash, :boolean
  end
end
