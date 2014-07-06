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
  has_many :sale_inclusions, :as => :inclusion
  has_many :banner_tags, :as => :tag
  attr_accessible :stock_id, :design_id, :cost
  scope :inventory_order, joins(:design, :body_style, :color, :size).order('designs.number', 'body_styles.position', 'colors.position', 'sizes.position')
  scope :of_size, lambda { |size| joins(:stock).merge(Stock.of_size(size)) }
  scope :size_order, lambda { joins(:size).order('sizes.position') }
  scope :of_color, lambda { |color| joins(:stock).where('stocks.color_id = ?', color) }
  
  def is_on_sale?
    color.is_on_sale? || product_color.is_on_sale? || sale_inclusions.applicable.first
  end
  
  def name
    "#{design.name} on #{stock.name}"
  end
  
  def in_stock?
    stashed? || inventory.andand.current_amount.andand.>(0)
  end
  
  def inventory
    inventory_snapshots.current.last
  end
  
  def stash!
    stashed_inventories.create unless stashed?
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
  
  def wholesale_price
    product.garment_cost size, color
  end
  
  def set_inventory amount
    inventory_snapshots.update_all :current => false
    inventory_snapshots.current.create :initial_amount => amount, :current_amount => amount
  end
  
  def decrement_inventory! quantity
    inventory.andand.update_attribute :current_amount, inventory.andand.current_amount.andand.-(quantity)
    
    unless stashed?
      if inventory.current_amount <= 0
        other_sizes_and_colors = product.garments
        other_sizes_and_colors.reject! { |garment| garment.inventory.andand.current_amount <= 0 }
        if other_sizes_and_colors.length == 0
          product.deactivate!
        end
      end
    end
  end
end
