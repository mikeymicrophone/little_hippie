class CreateSaleInclusions < ActiveRecord::Migration
  def change
    create_table :sale_inclusions do |t|
      t.belongs_to :sale
      t.string :inclusion_type
      t.integer :inclusion_id
      t.datetime :begin_date
      t.datetime :end_date
      t.boolean :active

      t.timestamps
    end
    add_index :sale_inclusions, :sale_id
    add_index :sale_inclusions, [:inclusion_type, :inclusion_id]
  end
end
