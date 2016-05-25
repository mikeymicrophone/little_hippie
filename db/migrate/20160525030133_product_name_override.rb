class ProductNameOverride < ActiveRecord::Migration
  def up
    add_column :products, :name_override, :string
  end

  def down
    remove_column :products, :name_override
  end
end
