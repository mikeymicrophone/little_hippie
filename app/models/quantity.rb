class Quantity < ActiveRecord::Base
  belongs_to :garment_purchase_order
  belongs_to :unit_price
  attr_accessible :purchased
end
