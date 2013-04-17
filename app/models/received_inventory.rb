class ReceivedInventory < ActiveRecord::Base
  belongs_to :print_purchase_order
  belongs_to :garment_purchase_order
  belongs_to :delivery
  has_one :delivery_address, :through => :delivery
  has_one :quantity, :through => :delivery
  has_one :garment, :through => :delivery
  belongs_to :first_snapshot, :class_name => 'InventorySnapshot'
  attr_accessible :amount_cancelled, :amount_delayed, :date_received, :delivery_id, :first_snapshot, :first_snapshot_id
  
  scope :without_snapshot, where(:first_snapshot_id => nil)
  
  before_create :set_receipt_date
  
  def set_receipt_date
    self.date_received = delivery.date_delivered
  end
  
end
