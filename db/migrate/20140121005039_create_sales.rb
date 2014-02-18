class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.integer :amount
      t.integer :percentage
      t.datetime :begin_date
      t.datetime :end_date
      t.boolean :active

      t.timestamps
    end
  end
end
