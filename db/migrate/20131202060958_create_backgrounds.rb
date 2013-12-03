class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :name
      t.string :image
      t.boolean :active
      
      t.timestamps
    end
  end
end
