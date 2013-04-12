class UnitPrice < ActiveRecord::Base
  belongs_to :stock
  belongs_to :garment
  attr_accessible :stock_id, :garment_id, :price
  
  scope :most_recent, order('created_at desc')
  
  def name
    "#{garment ? garment.name : stock.name} at #{price / 100.0}"
  end
end
