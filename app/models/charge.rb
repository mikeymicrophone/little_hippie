class Charge < ActiveRecord::Base
  belongs_to :cart
  has_many :items, :through => :cart
  has_many :shipping_addresses, :through => :cart
  belongs_to :coupon
  attr_accessible :cart_id, :amount, :token, :result
  scope :complete, lambda { where(:result => ['complete', 'approved', 'payment complete', 'Old Glory notified', 'packed for shipment', 'partially shipped', 'need to email customer', 'waiting for reply from customer', 'backordered']) }
  scope :incomplete, lambda { where(:result => [nil, 'declined', 'unauthorized']) }
  scope :ready_for_old_glory, lambda { where(:result => 'payment complete') }
  scope :pertinent_to_old_glory, lambda { joins(:cart).merge(Cart.pertinent_to_old_glory)}
  scope :old_glory_notified, lambda { where(:result => 'Old Glory notified') }
  scope :tracking_needed, lambda { old_glory_notified.joins(:cart).merge(Cart.untracked) }

  def customer_name
    cart.shipping_addresses.last.andand.first_name.to_s + ' ' + cart.shipping_addresses.last.andand.last_name.to_s
  end
  
  def email
    cart.shipping_addresses.last.andand.email
  end
  
  def dollar_amount
    amount / 100.0
  end
  
  def shippable?
    shippable_results.include? result
  end
  
  def shippable_results
    ['complete', 'approved', 'payment complete', 'Old Glory notified', 'packed for shipment', 'partially shipped']
  end
  
  def unshippable_results
    ['payment failed', 'need to email customer', 'waiting for reply from customer', 'backordered']
  end
  
  def completed?
    ['complete', 'approved', 'payment complete', 'Old Glory notified', 'packed for shipment', 'partially shipped', 'need to email customer', 'waiting for reply from customer', 'backordered', 'shipment_complete'].include? result
  end
end
