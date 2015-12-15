class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :display_text
      t.text :href
      t.integer :position
      t.boolean :active
      t.integer :parent_id
      t.timestamps
    end
  end
end
