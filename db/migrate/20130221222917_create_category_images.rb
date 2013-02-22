class CreateCategoryImages < ActiveRecord::Migration
  def change
    create_table :category_images do |t|
      t.belongs_to :category
      t.string :image
      t.datetime :display_start
      t.datetime :display_end

      t.timestamps
    end
    add_index :category_images, :category_id
  end
end
