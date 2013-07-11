class CreateMetaDescriptions < ActiveRecord::Migration
  def change
    create_table :meta_descriptions do |t|
      t.string :controller
      t.string :action
      t.integer :resource_id
      t.text :description
      t.text :keywords
      t.string :og_image
      t.boolean :current

      t.timestamps
    end
  end
end
