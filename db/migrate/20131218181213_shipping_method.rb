class ShippingMethod < ActiveRecord::Migration
  def up
    add_column :carts, :shipping_method, :integer
  end

  def down
    remove_column :carts, :shipping_method
  end
end
