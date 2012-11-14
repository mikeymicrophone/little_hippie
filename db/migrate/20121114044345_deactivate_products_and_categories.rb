class DeactivateProductsAndCategories < ActiveRecord::Migration
  def up
    add_column :products, :active, :boolean
    add_column :categories, :active, :boolean
  end

  def down
    remove_column :products, :active
    remove_column :categories, :active
  end
end
