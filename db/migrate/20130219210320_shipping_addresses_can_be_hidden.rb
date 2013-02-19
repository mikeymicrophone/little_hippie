class ShippingAddressesCanBeHidden < ActiveRecord::Migration
  def up
    add_column :shipping_addresses, :hidden, :datetime
  end

  def down
    remove_column :shipping_addresses, :hidden
  end
end
