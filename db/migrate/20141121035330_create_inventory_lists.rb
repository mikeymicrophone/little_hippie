class CreateInventoryLists < ActiveRecord::Migration
  def change
    create_table :inventory_lists do |t|
      t.string :xml_file

      t.timestamps
    end
  end
end
