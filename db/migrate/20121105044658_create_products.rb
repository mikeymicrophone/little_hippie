class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :design
      t.belongs_to :body_style
      t.integer    :price

      t.timestamps
    end
    add_index :products, :design_id
    add_index :products, :body_style_id
  end
end
