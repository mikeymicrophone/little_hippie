class CreateContentPages < ActiveRecord::Migration
  def change
    create_table :content_pages do |t|
      t.string :title
      t.string :slug
      t.text   :content
      t.boolean :active

      t.timestamps
    end
  end
end
