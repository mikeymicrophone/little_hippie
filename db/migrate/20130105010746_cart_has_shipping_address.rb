class CartHasShippingAddress < ActiveRecord::Migration
  def up
    add_column :carts, :shipping_address_id, :integer
    add_column :carts, :ip_address, :string
    add_column :shipping_addresses, :ip_address, :string
    add_column :shipping_addresses, :cart_id, :integer
  end

  def down
    remove_column :carts, :shipping_address_id
    remove_column :carts, :ip_address
    remove_column :shipping_addresses, :ip_address
    remove_column :shipping_addresses, :cart_id
  end
end
