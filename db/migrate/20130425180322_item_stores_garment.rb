class ItemStoresGarment < ActiveRecord::Migration
  def up
    add_column :items, :garment_id, :integer
  end

  def down
    remove_column :items, :garment_id
  end
end
