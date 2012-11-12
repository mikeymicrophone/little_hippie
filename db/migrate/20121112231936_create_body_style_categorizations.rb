class CreateBodyStyleCategorizations < ActiveRecord::Migration
  def change
    create_table :body_style_categorizations do |t|
      t.belongs_to :body_style
      t.belongs_to :category
      t.integer :position
      t.boolean :active

      t.timestamps
    end
    add_index :body_style_categorizations, :body_style_id
    add_index :body_style_categorizations, :category_id
  end
end
