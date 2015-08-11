class ProductAvailability < ActiveRecord::Migration
  def up
    add_column :products, :available, :boolean
  end

  def down
    remove_column :products, :available
  end
end
