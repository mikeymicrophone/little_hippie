class CreateImagePositionTemplates < ActiveRecord::Migration
  def change
    create_table :image_position_templates do |t|
      t.float :scale
      t.float :top
      t.float :left
      t.string :name
      t.integer :position
      t.belongs_to :product_manager

      t.timestamps
    end
    add_index :image_position_templates, :product_manager_id
  end
end
