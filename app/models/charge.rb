class Charge < ActiveRecord::Base
  belongs_to :cart
  has_many :shipping_addresses, :through => :cart
  belongs_to :coupon
  attr_accessible :cart_id, :amount, :token, :result
  scope :complete, where(:result => 'complete')
  
  def dollar_amount
    amount / 100.0
  end
end
