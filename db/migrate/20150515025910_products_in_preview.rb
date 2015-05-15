class ProductsInPreview < ActiveRecord::Migration
  def up
    add_column :products, :preview, :boolean
    add_column :products, :release_date, :datetime
  end

  def down
    remove_column :products, :preview
    remove_column :products, :release_date
  end
end
