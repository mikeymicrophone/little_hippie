class Garment < ActiveRecord::Base
  belongs_to :stock
  belongs_to :design
  has_one :color, :through => :stock
  has_one :size, :through => :stock
  has_one :body_style, :through => :stock
  has_many :stashed_inventories, :dependent => :destroy
  has_many :unit_prices, :dependent => :destroy
  has_many :quantities, :through => :unit_prices
  has_many :deliveries, :through => :quantities
  has_many :received_inventories, :through => :deliveries
  has_many :inventory_snapshots, :dependent => :destroy
  attr_accessible :stock_id, :design_id
  
  def name
    "#{design.name} on #{stock.name}"
  end
  
  def in_stock?
    stashed? || inventory.current_amount > 0
  end
  
  def inventory
    inventory_snapshots.current.last
  end
  
  def stashed?
    stashed_inventories.any?
  end
  
  def product
    stock.products.where(:design_id => design_id).first
  end
  
  def product_color
    ProductColor.find_by_product_id_and_color_id product.id, color.id
  end
end
