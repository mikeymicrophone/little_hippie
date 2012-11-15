class ProductCopy < ActiveRecord::Migration
  def up
    add_column :products, :copy, :text
  end

  def down
    remove_column :products, :copy
  end
end
