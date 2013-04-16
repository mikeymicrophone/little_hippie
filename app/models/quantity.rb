class Quantity < ActiveRecord::Base
  belongs_to :garment_purchase_order
  belongs_to :print_purchase_order
  belongs_to :unit_price
  has_one :stock, :through => :unit_price
  has_one :garment, :through => :unit_price
  belongs_to :source_stock, :class_name => 'Quantity'
  attr_accessible :purchased, :garment_purchase_order_id, :unit_price_id, :garment_purchase_order, :source_stock, :source_stock_id
  
  def print_on_stock
    Quantity.new :garment_purchase_order => garment_purchase_order, :source_stock => self
  end
end
