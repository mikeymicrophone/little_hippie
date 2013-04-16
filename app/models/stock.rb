class Stock < ActiveRecord::Base
  belongs_to :body_style_size
  belongs_to :color
  has_many :unit_prices
  has_many :products, :through => :body_style_size
  has_many :garments
  attr_accessible :body_style_size_id, :color_id
  
  def name
    "#{color.name} #{body_style_size.name}"
  end
  
  def current_price
    unit_prices.most_recent.first.price / 100.0
  end
  
  def priced?
    unit_prices.any?
  end
end
