class StashedInventory < ActiveRecord::Base
  belongs_to :garment
  belongs_to :delivery_address
  attr_accessible :garment_id, :delivery_address_id
end
