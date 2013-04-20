class PrintPurchaseOrder < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :billing_address
  belongs_to :garment_purchase_order
  has_many :quantities
  has_many :deliveries, :through => :quantities
  attr_accessible :supplier_id, :billing_address_id, :garment_purchase_order_id
  
  def name
    "#{supplier.name} #{created_at.strftime("%m/%y")}"
  end
end
