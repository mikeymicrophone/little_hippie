class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.string :name
      t.integer :number
      t.string :art

      t.timestamps
    end
  end
end
