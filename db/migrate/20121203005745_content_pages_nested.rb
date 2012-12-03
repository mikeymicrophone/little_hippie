class ContentPagesNested < ActiveRecord::Migration
  def up
    add_column :content_pages, :parent_id, :integer
    add_column :content_pages, :position, :integer
    
    ContentPage.find_or_create_by_title 'Navigation'
  end

  def down
    remove_column :content_pages, :parent_id
    remove_column :content_pages, :position
  end
end
