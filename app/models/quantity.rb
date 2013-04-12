class Quantity < ActiveRecord::Base
  belongs_to :garment_purchase_order
  belongs_to :unit_price
  has_one :stock, :through => :unit_price
  has_one :garment, :through => :unit_price
  attr_accessible :purchased, :garment_purchase_order_id, :unit_price_id
end
