class ProductColor < ActiveRecord::Base
  belongs_to :product
  has_many :items
  has_many :carts, :through => :items
  has_many :wishlist_items
  has_one :design, :through => :product
  has_one :body_style, :through => :product
  has_many :body_style_categorizations, :through => :body_style
  has_many :body_style_sizes, :through => :body_style
  has_many :sizes, :through => :body_style_sizes
  has_many :stocks, :through => :body_style_sizes
  has_many :garments, :through => :stocks, :conditions => "garments.design_id = products.design_id"
  has_many :stashed_inventories, :through => :garments
  has_many :inventory_snapshots, :through => :garments
  belongs_to :color
  has_many :inventories, :dependent => :destroy
  has_many :product_images, :dependent => :destroy
  has_many :category_product_features, :dependent => :destroy
  has_many :body_style_product_features, :dependent => :destroy
  has_many :categories, :through => :product
  has_many :sale_inclusions, :as => :inclusion
  has_many :banner_tags, :as => :tag
  attr_accessible :product_id, :color_id, :og_code
  validates_presence_of :product_id, :color_id
  validates_uniqueness_of :color_id, :scope => :product_id
  after_create :create_inventory_objects
  delegate :css_hex_code, :to => :color
  scope :by_code_order, joins(:design, :body_style).order('designs.number', 'body_styles.code')
  scope :color_order, joins(:color).order('colors.position')
  scope :inventory_order, by_code_order.joins(:color).order('colors.position')
  scope :active_product, joins(:product).where('products.active = ?', true)
  scope :active_in_category, lambda { |category_id| joins(:body_style_categorizations).where(:body_style_categorizations => {:category_id => category_id, :active => true}) }
  scope :without_og_code, lambda { where :og_code => nil }
  # scope :popular, lambda { select('"product_colors".*, "items".*, sum("items"."quantity") as purchases').joins(:items).group('product_colors.id').order('purchases desc') }
  
  define_index do
    indexes design.name
    indexes design.number
    indexes body_style.name
    indexes body_style.code
    indexes color.name
    indexes color.code
    indexes product.code, :as => :product_code, :sortable => true
  end
  
  def self.top_40
    all.sort_by { |product_color| product_color.items.purchased.sum(:quantity) }[-40..-1]
  end
  
  def self.selection_of_popular
    top_40.sample 10
  end
  
  def self.selection_of_unique_popular
    product_colors = top_40.sample 10
    products = product_colors.map { |pc| pc.product_id }
    return product_colors if products.uniq.length == 10
    while products.uniq.length < 10 do
      products_seen = []
      number_to_replace = 0
      product_colors.each do |product_color|
        if products_seen.include?(product_color.product_id)
          product_colors.reject! { |p| p.id == product_color.id }
          products = product_colors.map { |pc| pc.product_id }
          number_to_replace += 1
        else
          products_seen < product_color.product_id
        end
      end
      product_colors < top_40.sample(number_to_replace)
    end
  end

  def is_on_sale?
    sale_inclusions.applicable.first
  end
  
  def reprintable?
    stashed_inventories.any?
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
  
  def old_glory_url
    "http://oldglory.com/lp/Grateful-Dead/p/" + og_code.to_s
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
  
  def create_inventory_objects
    body_style_sizes.each do |body_style_size|
      Stock.find_or_create_by_body_style_size_id_and_color_id body_style_size.id, color.id
    end
    
    stocks.each do |stock|
      Garment.find_or_create_by_design_id_and_stock_id design.id, stock.id
    end
  end
end
