class Garment < ActiveRecord::Base
  belongs_to :stock
  belongs_to :design
  has_many :stashed_inventories
  has_many :unit_prices
  has_many :quantities, :through => :unit_prices
  has_many :deliveries, :through => :quantities
  has_many :received_inventories, :through => :deliveries
  has_many :inventory_snapshots
  attr_accessible :stock_id, :design_id
  
  def name
    "#{design.name} on #{stock.name}"
  end
  
  def in_stock?
    stashed_inventories.any? || inventory.current_amount > 0
  end
  
  def inventory
    inventory_snapshots.order("created_at desc").last
  end
end
