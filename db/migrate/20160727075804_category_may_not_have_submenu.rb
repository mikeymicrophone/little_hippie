class CategoryMayNotHaveSubmenu < ActiveRecord::Migration
  def up
    add_column :categories, :has_submenu, :boolean
  end

  def down
    remove_column :categories, :has_submenu
  end
end
