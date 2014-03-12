class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  belongs_to :landing_color, :class_name => 'Color'
  has_many :categories, :through => :body_style
  has_many :product_colors, :dependent => :destroy, :after_add => [:set_landing_color, :generate_first_image]
  has_many :product_images, :through => :product_colors
  has_many :colors, :through => :product_colors
  has_many :sizes, :through => :body_style
  has_many :stocks, :through => :product_colors, :conditions => 'stocks.color_id = product_colors.color_id'
  has_many :garments, :through => :stocks, :conditions => 'garments.design_id = products.design_id'
  has_many :inventory_snapshots, :through => :garments, :conditions => ['inventory_snapshots.current = ?', true]
  has_many :stashed_inventories, :through => :garments
  has_many :inventories, :through => :product_colors
  has_many :items, :through => :product_colors
  has_many :friend_emails
  has_many :comments
  has_many :likes, :as => :favorite
  has_many :coupon_products
  has_many :coupons, :through => :coupon_products
  has_many :category_product_features, :through => :product_colors
  has_many :body_style_product_features, :through => :product_colors
  has_many :sale_inclusions, :as => :inclusion
  has_many :banner_tags, :as => :tag
  attr_accessible :design_id, :body_style_id, :price, :active, :code, :copy, :open_graph_id
  scope :active, {:conditions => {:active => true}}
  scope :inactive, {:conditions => {:active => false}}
  before_create :use_base_price, :generate_code, :default_to_active
  acts_as_list
  scope :ordered, :order => :position
  scope :alphabetical, order('designs.name, body_styles.name').joins(:design, :body_style)
  scope :with_body_styles, lambda { |body_styles| where(:body_style_id => [body_styles.map(&:id)]) }
  scope :with_design, lambda { |design| where(:design_id => design.id) }
  scope :inventory_order, joins(:design, :body_style).order('designs.code', 'body_styles.position')
  delegate :age_group, :cut_type, :to => :body_style
  
  validates_uniqueness_of :design_id, :scope => :body_style_id
  
  define_index do
    indexes design.name
    indexes design.number
    indexes body_style.name
    indexes body_style.code
    indexes code
  end
  
  def is_on_sale?
    body_style.is_on_sale? || design.is_on_sale? || sale_inclusions.applicable.first
  end
  
  def sale
    is_on_sale?.andand.sale
  end
  
  def name
    design.name + ' ' + body_style.name
  end
  
  def url_name
    name.gsub(/[\s\?\'\/]/, '-')
  end
  
  def to_param
    "#{id}-#{url_name}"
  end
  
  def art size = nil
    design.art_url size
  end
  
  def generate_code
    self.code = "#{body_style.code}-#{design.number}"
  end
  
  def primary_image size = nil
    if product_images.last
      begin
        product_images.newest.first.image_url(size)
      rescue ArgumentError
        product_images.newest.first.image_url
      end
    else
      begin
        art(size)
      rescue ArgumentError
        art
      end
    end
  end
  
  def landing_product_color
    product_colors.find_by_color_id(landing_color_id) || product_colors.first
  end
  
  def use_base_price
    self.price = body_style.base_price if price.blank?
  end
  
  def dollar_price
    price.andand./(100.0)
  end
  
  def sale_price
    if sale.andand.amount.present?
      dollar_price - sale.amount/100.0
    elsif sale.andand.percentage.present?
      dollar_price * ((100 - sale.percentage)/100.0)
    else
      dollar_price
    end
  end
  
  def size_price size
    if size == Size.xxl && body_style.xxl_price.andand.>(0)
      body_style.xxl_price / 100.0
    elsif size == Size.xxxl && body_style.xxxl_price.andand.>(0)
      body_style.xxxl_price / 100.0
    else
      dollar_price
    end
  end
  
  def similar_items
    ((body_style.products.active +
    Product.active.with_body_styles(age_group.andand.body_styles.to_a).with_design(design) +
    Product.active.with_body_styles(cut_type.andand.body_styles.to_a).with_design(design) +
    design.products.active).uniq - [self]).sort_by { rand }
  end
  
  def default_to_active
    self.active = true
  end
  
  def random_color
    colors.sample
  end
  
  def number_in_stock
    inventory_snapshots.sum(:current_amount)
  end
  
  def stashed?
    stashed_inventories.present?
  end
  
  def number_in_stock_legacy_inventory_system
    inventories.sum(:amount)
  end
  
  def generate_image scale = 50, top_offset = 0, left_offset = 0, template_name = nil, product_manager = nil
    return unless body_style.image.present? && design.art.present?
    image_position_template = ImagePositionTemplate.find_or_create_by_top_and_left_and_scale :top => top_offset, :left => left_offset, :scale => scale, :product_manager => product_manager, :name => name
    body_style_image = MiniMagick::Image.open(body_style.image)
    design_image = MiniMagick::Image.open(design.art.full_enlargement)
    design_image.sample "#{scale}%"
    product_image = body_style_image.composite design_image, 'png' do |pi|
      pi.gravity 'center'
      pi.geometry "#{'+' if left_offset.to_i >= 0}#{left_offset}#{'+' if top_offset.to_i >= 0}#{top_offset}"
    end
    product_image.write "./tmp/product_image.png"
    if product_colors.present?
      product_image = product_colors.first.product_images.create :image => File.open('./tmp/product_image.png'), :image_position_template => image_position_template
    end
  end
  
  def generate_image_from_template template
    if template
      generate_image template.scale, template.top, template.left
    else
      generate_image
    end
  end
  
  def generate_first_image product_color
    if product_images.empty?
      template = body_style.image_position_templates.last_used.first
      generate_image_from_template template if template
    end
  end
  
  def set_landing_color product_color
    self.landing_color_id ||= product_color.color_id
    save
  end
end
