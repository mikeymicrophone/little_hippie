class WholesaleOrder < ActiveRecord::Base
  has_many :wholesale_items
  belongs_to :reseller
  attr_accessible :reseller_id, :shipping_address_id, :status, :discount_percentage
  attr_default :discount_percentage, 0.0
  
  scope :in_progress, lambda { where(:status => 'in progress') }
  scope :submitted, lambda { where(:status => 'submitted') }
  before_create :set_order_status
  
  def charge_customer
    begin
      charge = Stripe::Charge.create :amount => price.to_i, :customer => reseller.stripe_customer_id, :currency => 'USD', :description => "Wholesale Order #{id}"
      Rails.logger.info charge.inspect
      return charge
    rescue
      return nil
    end
  end
  
  def price
    wholesale_items.inject(0) { |sum, item| sum + item.quantity * item.garment.wholesale_price } * ((100.0 - discount_percentage)/100.0)
  end
  
  def dollar_price
    price / 100.0
  end
  
  def item_count
    wholesale_items.sum :quantity
  end
  
  def in_progress?
    status == 'in progress'
  end
  
  def set_order_status
    self.status = 'in progress'
  end
end
