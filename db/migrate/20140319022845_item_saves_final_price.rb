class ItemSavesFinalPrice < ActiveRecord::Migration
  def up
    add_column :items, :final_price, :integer
  end

  def down
    remove_column :items, :final_price
  end
end
