class StashedInventory < ActiveRecord::Base
  belongs_to :garment
  has_one :color, :through => :garment
  has_one :size, :through => :garment
  belongs_to :delivery_address
  attr_accessible :garment_id, :delivery_address_id
  
  delegate :product, :to => :garment
end
