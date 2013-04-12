class GarmentPurchaseOrder < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :billing_address
  belongs_to :shipping_address
  # attr_accessible :title, :body
end
