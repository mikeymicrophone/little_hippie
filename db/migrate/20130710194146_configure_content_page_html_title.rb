class ConfigureContentPageHtmlTitle < ActiveRecord::Migration
  def up
    add_column :content_pages, :html_title, :string
  end

  def down
    remove_column :content_pages, :html_title
  end
end
