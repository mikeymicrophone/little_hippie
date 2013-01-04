class Charge < ActiveRecord::Base
  belongs_to :cart
  attr_accessible :cart_id, :amount, :token
  scope :complete, where(:result => 'complete')
end
