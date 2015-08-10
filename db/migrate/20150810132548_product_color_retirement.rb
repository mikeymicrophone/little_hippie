class ProductColorRetirement < ActiveRecord::Migration
  def up
    add_column :product_colors, :discontinued, :boolean, :default => false
  end

  def down
    remove_column :product_colors, :discontinued
  end
end
