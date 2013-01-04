class CreditCard < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :position, :status, :stripe_customer_id
end
