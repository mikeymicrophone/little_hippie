class CreateBodyStyleSizes < ActiveRecord::Migration
  def change
    create_table :body_style_sizes do |t|
      t.belongs_to :body_style
      t.belongs_to :size

      t.timestamps
    end
    add_index :body_style_sizes, :body_style_id
    add_index :body_style_sizes, :size_id
  end
end
