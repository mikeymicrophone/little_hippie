class CreditCard < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :position, :status, :stripe_customer_id
  
  def display
    last4.html_safe
  end
  
  def stripe_object
    Stripe::Customer.retrieve stripe_customer_id
  end
  
  def last4
    stripe_object.active_card.last4
  end
end
