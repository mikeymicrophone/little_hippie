class ProductPosition < ActiveRecord::Migration
  def up
    add_column :products, :position, :integer
  end

  def down
    remove_column :products, :position, :integer
  end
end
