class AddMailingAddressFields < ActiveRecord::Migration
  def up
    remove_column :mailing_list_registrations, :state_id
    remove_column :mailing_list_registrations, :country_id
    add_column :mailing_list_registrations, :state, :string
    add_column :mailing_list_registrations, :festival, :string
    add_column :mailing_list_registrations, :referral_id, :integer
  end

  def down
    remove_column :mailing_list_registrations, :state
    remove_column :mailing_list_registrations, :festival
    remove_column :mailing_list_registrations, :referral_id
    add_column :mailing_list_registrations, :state_id, :integer
    add_column :mailing_list_registrations, :country_id, :integer
  end
end
