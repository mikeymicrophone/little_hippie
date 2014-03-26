class ProductsStoreCosts < ActiveRecord::Migration
  def up
    add_column :body_styles, :cost, :integer
    add_column :products, :cost, :integer
    add_column :garments, :cost, :integer
  end

  def down
    remove_column :body_styles, :cost
    remove_column :products, :cost
    remove_column :garments, :cost
  end
end
