class WholesaleOrder < ActiveRecord::Base
  has_many :wholesale_items
  belongs_to :shipping_address
  belongs_to :reseller
  attr_accessible :reseller_id, :shipping_address_id, :status, :discount_percentage, :reseller, :shipping_address
  attr_default :discount_percentage, 0.0
  
  scope :in_progress, lambda { where(:status => 'in progress') }
  scope :submitted, lambda { where(:status => 'submitted') }
  scope :approved, lambda { where(:status => 'approved') }
  before_create :set_order_status
  validates :reseller_id, :presence => true
  
  def charge_customer
    return true if reseller.delay_payment
    begin
      Stripe.api_key = ENV['WHOLESALE_STRIPE_SECRET_KEY']
      charge = Stripe::Charge.create :amount => price.to_i, :customer => reseller.stripe_customer_id, :currency => 'USD', :description => "Wholesale Order #{id}"
      Rails.logger.info charge.inspect
      return charge
    rescue StandardError => ex
      Rails.logger.info ex.message
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
  
  def submit!
    update_attribute :status, 'submitted'
  end
  
  def set_order_status
    self.status = 'in progress'
  end
  
  def items_available_in_quantity
    begin
      wholesale_items.all? { |item| item.quantity <= item.inventory_amount }
    rescue
      false
    end
  end
end
