class WholesaleOrder < ActiveRecord::Base
  has_many :wholesale_items
  attr_accessible :reseller_id, :shipping_address_id, :status
  attr_default :discount_percentage, 0.0
  
  scope :in_progress, lambda { where(:status => 'in progress') }
  before_create :set_order_status
  
  def price
    wholesale_items.inject(0) { |sum, item| sum + item.quantity * item.garment.wholesale_price } * ((100.0 - discount_percentage)/100.0)
  end
  
  def dollar_price
    price / 100.0
  end
  
  def in_progress?
    status == 'in progress'
  end
  
  def set_order_status
    self.status = 'in progress'
  end
end
