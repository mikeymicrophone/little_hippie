class ShippingAddressHasCompany < ActiveRecord::Migration
  def up
    add_column :shipping_addresses, :company, :string
    remove_column :shipping_addresses, :country
    add_column :shipping_addresses, :country_id, :integer
    remove_column :shipping_addresses, :state
    add_column :shipping_addresses, :state_id, :integer
  end

  def down
    remove_column :shipping_addresses, :company
  end
end
