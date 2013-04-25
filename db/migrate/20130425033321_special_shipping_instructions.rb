class SpecialShippingInstructions < ActiveRecord::Migration
  def up
    add_column :carts, :shipping_instructions, :text
  end

  def down
    remove_column :carts, :shipping_instructions
  end
end
