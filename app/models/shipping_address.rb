class ShippingAddress < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :city, :country, :email, :first_name, :last_name, :phone, :position, :state, :street, :street2, :zip, :customer_id
  acts_as_list :scope => :customer_id
end
