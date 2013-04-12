class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.belongs_to :supplier
      t.string :first_name
      t.string :last_name
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
    add_index :billing_addresses, :supplier_id
    add_index :billing_addresses, :state_id
    add_index :billing_addresses, :country_id
  end
end
