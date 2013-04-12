class CreateDeliveryAddresses < ActiveRecord::Migration
  def change
    create_table :delivery_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :email
      t.string :phone
      t.string :street
      t.string :street2
      t.string :city
      t.belongs_to :state
      t.belongs_to :country
      t.string :zip
      t.datetime :hidden
      t.integer :position

      t.timestamps
    end
    add_index :delivery_addresses, :state_id
    add_index :delivery_addresses, :country_id
  end
end
