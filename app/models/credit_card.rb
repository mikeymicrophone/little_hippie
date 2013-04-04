class CreditCard < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :position, :status, :stripe_customer_id
  
  def display
    stripe_customer_id[-4..-1].html_safe
  end
end
