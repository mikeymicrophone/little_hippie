class CreateGarments < ActiveRecord::Migration
  def change
    create_table :garments do |t|
      t.belongs_to :stock
      t.belongs_to :design

      t.timestamps
    end
    add_index :garments, :stock_id
    add_index :garments, :design_id
  end
end
