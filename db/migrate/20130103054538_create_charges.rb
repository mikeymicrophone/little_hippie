class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.belongs_to :cart
      t.string :token
      t.integer :amount
      t.string :result

      t.timestamps
    end
    add_index :charges, :cart_id
  end
end
