class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :primary_contact_name
      t.string :phone
      t.string :email
      t.belongs_to :billing_address
      t.text :description
      t.string :website

      t.timestamps
    end
    add_index :suppliers, :billing_address_id
  end
end
