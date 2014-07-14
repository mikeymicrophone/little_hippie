class WholesaleOrder < ActiveRecord::Base
  attr_accessible :reseller_id, :shipping_address_id, :status
  
  scope :in_progress, lambda { where(:status => 'in progress') }
  before_create :set_order_status
  
  def in_progress?
    status == 'in progress'
  end
  
  def set_order_status
    self.status = 'in progress'
  end
end
