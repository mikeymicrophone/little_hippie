class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.belongs_to :body_style_size
      t.belongs_to :color

      t.timestamps
    end
    add_index :stocks, :body_style_size_id
    add_index :stocks, :color_id
  end
end
