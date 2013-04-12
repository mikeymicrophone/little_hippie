class Supplier < ActiveRecord::Base
  belongs_to :billing_address
  attr_accessible :description, :email, :name, :phone, :primary_contact_name, :website, :billing_address_id
end
