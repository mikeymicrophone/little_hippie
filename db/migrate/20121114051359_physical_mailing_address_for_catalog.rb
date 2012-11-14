class PhysicalMailingAddressForCatalog < ActiveRecord::Migration
  def up
    add_column :mailing_list_registrations, :street, :string
    add_column :mailing_list_registrations, :street2, :string
    add_column :mailing_list_registrations, :city, :string
    add_column :mailing_list_registrations, :zip, :string
    add_column :mailing_list_registrations, :state_id, :integer
    add_column :mailing_list_registrations, :country_id, :integer
  end

  def down
    remove_column :mailing_list_registrations, :street
    remove_column :mailing_list_registrations, :street2
    remove_column :mailing_list_registrations, :city
    remove_column :mailing_list_registrations, :zip
    remove_column :mailing_list_registrations, :state_id
    remove_column :mailing_list_registrations, :country_id
  end
end
