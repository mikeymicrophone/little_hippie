class WholesaleItem < ActiveRecord::Base
  attr_accessible :garment_id, :quantity, :wholesale_order_id
  validates_presence_of :garment_id, :wholesale_order_id, :quantity
  belongs_to :garment
  belongs_to :wholesale_order
  has_one :product, :through => :garment
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  has_one :color, :through => :garment
  has_one :size, :through => :garment
end
