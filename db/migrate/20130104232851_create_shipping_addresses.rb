class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.belongs_to :customer
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :street
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.integer :position

      t.timestamps
    end
    add_index :shipping_addresses, :customer_id
  end
end
