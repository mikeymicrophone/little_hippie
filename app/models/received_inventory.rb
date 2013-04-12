class ReceivedInventory < ActiveRecord::Base
  belongs_to :print_purchase_order
  belongs_to :garment_purchase_order
  belongs_to :quantity
  belongs_to :first_snapshot
  attr_accessible :amount_cancelled, :amount_delayed, :date_received
end
