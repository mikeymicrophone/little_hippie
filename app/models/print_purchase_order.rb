class PrintPurchaseOrder < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :billing_address
  belongs_to :garment_purchase_order
  # attr_accessible :title, :body
end
