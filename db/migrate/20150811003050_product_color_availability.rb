class ProductColorAvailability < ActiveRecord::Migration
  def up
    add_column :product_colors, :available, :boolean
  end

  def down
    remove_column :product_colors, :available
  end
end
