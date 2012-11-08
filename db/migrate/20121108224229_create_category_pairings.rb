class CreateCategoryPairings < ActiveRecord::Migration
  def change
    create_table :category_pairings do |t|
      t.belongs_to :category
      t.belongs_to :content_page
      t.integer :position

      t.timestamps
    end
    add_index :category_pairings, :category_id
    add_index :category_pairings, :content_page_id
  end
end
