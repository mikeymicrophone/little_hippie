class Delivery < ActiveRecord::Base
  belongs_to :delivery_address
  belongs_to :quantity
  attr_accessible :delivery_address_id, :quantity_id, :quantity_delivered
end
