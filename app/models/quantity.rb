class Quantity < ActiveRecord::Base
  belongs_to :garment_purchase_order
  belongs_to :print_purchase_order
  belongs_to :unit_price
  has_one :stock, :through => :unit_price
  has_one :garment, :through => :unit_price
  has_one :color, :through => :stock
  has_one :design, :through => :garment
  has_many :deliveries
  has_many :delivery_addresses, :through => :deliveries
  belongs_to :source_stock, :class_name => 'Quantity'
  has_many :printed_garments, :class_name => 'Quantity', :foreign_key => :source_stock_id
  attr_accessible :purchased, :garment_purchase_order_id, :unit_price_id, :garment_purchase_order, :source_stock, :source_stock_id, :print_purchase_order_id
  
  def print_on_stock
    Quantity.new :garment_purchase_order => garment_purchase_order, :source_stock => self
  end
  
  def name
    "#{purchased} of #{garment ? garment.name : stock.name}"
  end
  
  def total_delivered
    deliveries.sum :quantity_delivered
  end
end
