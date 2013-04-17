class UnitPrice < ActiveRecord::Base
  belongs_to :body_style_size
  belongs_to :design
  belongs_to :stock
  belongs_to :garment
  has_many :quantities
  attr_accessible :stock_id, :garment_id, :price, :body_style_size_id, :design_id
  
  scope :most_recent, order('created_at desc')
  scope :with_garment, where('garment_id is not null')
  scope :for_stock, where('stock_id is not null and garment_id is null')
  scope :size_only, where(:stock_id => nil)
  scope :design_only, where(:garment_id => nil)
  
  def name
    "#{garment ? garment.name : (stock ? stock.name : (body_style_size ? body_style_size.name : design.name))} at #{price / 100.0}"
  end
end
