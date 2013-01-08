class GiftWrap < ActiveRecord::Migration
  def up
    add_column :items, :gift_wrap, :boolean
    add_column :items, :quantity, :integer
  end

  def down
    remove_column :items, :gift_wrap
    remove_column :items, :quantity
  end
end
