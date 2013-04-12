class CartHasGiftNote < ActiveRecord::Migration
  def up
    add_column :carts, :gift_note, :text
  end

  def down
    remove_column :carts, :gift_note
  end
end
