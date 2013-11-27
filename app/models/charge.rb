class Charge < ActiveRecord::Base
  belongs_to :cart
  has_many :shipping_addresses, :through => :cart
  belongs_to :coupon
  attr_accessible :cart_id, :amount, :token, :result
  scope :complete, where(:result => ['complete', 'approved', 'payment complete', 'packed for shipment', 'partially shipped', 'need to email customer', 'waiting for reply from customer', 'backordered'])
  scope :incomplete, where(:result => [nil, 'declined', 'unauthorized'])
  
  def dollar_amount
    amount / 100.0
  end
  
  def shippable?
    shippable_results.include? result
  end
  
  def shippable_results
    ['complete', 'approved', 'payment complete', 'packed for shipment', 'partially shipped']
  end
  
  def unshippable_results
    ['payment failed', 'need to email customer', 'waiting for reply from customer', 'backordered']
  end
  
  def completed?
    ['complete', 'approved', 'payment complete', 'packed for shipment', 'partially shipped', 'need to email customer', 'waiting for reply from customer', 'backordered', 'shipment_complete'].include? result
  end
end
