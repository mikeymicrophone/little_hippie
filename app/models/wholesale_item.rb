class WholesaleItem < ActiveRecord::Base
  attr_accessible :garment_id, :quantity, :wholesale_order_id
  validates_presence_of :garment_id, :wholesale_order_id
  belongs_to :garment
  belongs_to :wholesale_order
end
