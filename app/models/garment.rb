class Garment < ActiveRecord::Base
  belongs_to :stock
  belongs_to :design
  has_many :stashed_inventories
  has_many :received_inventories
  attr_accessible :stock_id, :design_id
  
  def name
    "#{design.name} on #{stock.name}"
  end
end
