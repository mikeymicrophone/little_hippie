class InventorySnapshot < ActiveRecord::Base
  belongs_to :garment
  has_many :received_inventories, :foreign_key => :first_snapshot_id, :dependent => :nullify
  attr_accessible :current_amount, :initial_amount, :garment, :garment_id
  
  def amount
    "#{current_amount}/#{initial_amount}"
  end
end
