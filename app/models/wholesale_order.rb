class WholesaleOrder < ActiveRecord::Base
  attr_accessible :reseller_id, :shipping_address_id, :status
end
