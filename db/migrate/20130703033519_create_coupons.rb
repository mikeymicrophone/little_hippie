class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :amount
      t.integer :percentage
      t.integer :lower_limit
      t.integer :upper_limit
      t.datetime :valid_date
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
