class ContentPageCanHideChildren < ActiveRecord::Migration
  def up
    add_column :content_pages, :show_children, :boolean
  end

  def down
    remove_column :content_pages, :show_children
  end
end
