class Garment < ActiveRecord::Base
  belongs_to :stock
  belongs_to :design
  attr_accessible :stock_id, :design_id
  
  def name
    "#{design.name} on #{stock.name}"
  end
end
