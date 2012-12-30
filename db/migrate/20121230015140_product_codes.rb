class ProductCodes < ActiveRecord::Migration
  def up
    add_column :products, :code, :string
  end

  def down
    remove_column :products, :code
  end
end
