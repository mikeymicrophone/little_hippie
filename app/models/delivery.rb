class Delivery < ActiveRecord::Base
  belongs_to :delivery_address
  belongs_to :quantity
  has_one :garment, :through => :quantity
  has_many :received_inventories
  has_one :print_purchase_order, :through => :quantity
  has_one :garment_purchase_order, :through => :quantity
  attr_accessible :delivery_address_id, :quantity_id, :quantity_delivered
  
  def name
    "#{quantity_delivered}/#{quantity.andand.name} to #{delivery_address.andand.name}"
  end
end
