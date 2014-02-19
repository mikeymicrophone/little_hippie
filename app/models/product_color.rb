class ProductColor < ActiveRecord::Base
  belongs_to :product
  has_many :items
  has_many :wishlist_items
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  has_many :body_style_categorizations, :through => :body_style
  has_many :body_style_sizes, :through => :body_style
  has_many :stocks, :through => :body_style_sizes
  has_many :garments, :through => :stocks, :conditions => "garments.design_id = products.design_id"
  has_many :inventory_snapshots, :through => :garments
  belongs_to :color
  has_many :inventories, :dependent => :destroy
  has_many :product_images, :dependent => :destroy
  has_many :category_product_features, :dependent => :destroy
  has_many :body_style_product_features, :dependent => :destroy
  has_many :categories, :through => :product
  has_many :sale_inclusions, :as => :inclusion
  attr_accessible :product_id, :color_id, :og_code
  validates_presence_of :product_id, :color_id
  validates_uniqueness_of :color_id, :scope => :product_id
  after_create :add_to_category_features
  delegate :css_hex_code, :to => :color
  scope :by_code_order, joins(:design, :body_style).order('designs.number', 'body_styles.code')
  scope :inventory_order, by_code_order.joins(:color).order('colors.position')
  scope :active_product, joins(:product).where('products.active = ?', true)
  scope :active_in_category, lambda { |category_id| joins(:body_style_categorizations).where(:body_style_categorizations => {:category_id => category_id, :active => true}) }
  
  define_index do
    indexes design.name
    indexes design.number
    indexes body_style.name
    indexes body_style.code
    indexes color.name
    indexes color.code
    indexes product.code, :as => :product_code, :sortable => true
  end

  def is_on_sale?
    sale_inclusions.applicable.first
  end

  def name
    product.name + " in " + color.name
  end
  
  def code
    "#{product.andand.code}-#{color.andand.code}"
  end
  
  def image size=nil
    product_images.last.andand.image_url size
  end
  
  def in_inventory
    inventory_snapshots.where('stocks.color_id' => color_id).sum(:current_amount)
  end
  
  def stocks_of_this_color
    stocks.select { |s| s.color_id == color_id }
  end
  
  def garments_of_this_color
    stocks_of_this_color.map(&:garments).flatten
  end
  
  def inventory_snapshots_of_this_color
    garments_of_this_color.map(&:inventory_snapshots).flatten
  end
  
  def add_to_category_features
    categories.each do |c|
      feature = category_product_features.create :category_id => c.id
      feature.move_to_top
    end
  
    feature = body_style_product_features.create :body_style_id => body_style.id
    feature.move_to_top
  end
end
