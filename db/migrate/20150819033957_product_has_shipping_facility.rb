class ProductHasShippingFacility < ActiveRecord::Migration
  def up
    add_column :products, :shipping_facility, :integer
  end

  def down
    remove_column :products, :shipping_facility
  end
end
