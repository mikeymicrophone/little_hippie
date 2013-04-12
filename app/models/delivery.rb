class Delivery < ActiveRecord::Base
  belongs_to :delivery_address
  belongs_to :print_purchase_order
  belongs_to :garment_purchase_order
  # attr_accessible :title, :body
end
