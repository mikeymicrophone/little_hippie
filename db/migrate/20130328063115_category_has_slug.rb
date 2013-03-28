class CategoryHasSlug < ActiveRecord::Migration
  def up
    add_column :categories, :slug, :string
  end

  def down
    remove_column :categories, :slug
  end
end
