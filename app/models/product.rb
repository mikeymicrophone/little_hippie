class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  belongs_to :landing_color, :class_name => 'Color'
  has_many :categories, :through => :body_style
  has_many :product_colors, :dependent => :destroy, :after_add => [:set_landing_color, :generate_first_image, :feature_color]
  has_many :product_images, :through => :product_colors
  has_many :colors, :through => :product_colors
  has_many :body_style_sizes, :through => :body_style
  has_many :sizes, :through => :body_style
  has_many :stocks, :through => :product_colors, :conditions => 'stocks.color_id = product_colors.color_id'
  has_many :garments, :through => :stocks, :conditions => 'garments.design_id = products.design_id'
  has_many :inventory_snapshots, :through => :garments, :conditions => ['inventory_snapshots.current = ?', true]
  has_many :stashed_inventories, :through => :garments
  has_many :artwork_images, :through => :garments
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
  has_many :banners, :through => :banner_tags, :order => 'banner_tags.position'
  attr_accessible :design_id, :body_style_id, :name_override, :price, :active, :code, :copy, :open_graph_id, :cost, :preview, :target_share_count, :target_post_id, :shipping_facility
  attr_default :available, true
  
  scope :active, lambda { where(:active => true) }
  scope :body_style_active, lambda { joins(:body_style).where('body_styles.active' => true)}
  scope :inactive, lambda { where :active => false }
  before_create :use_base_price, :use_base_cost, :generate_code, :default_to_active
  acts_as_list
  scope :ordered, lambda { order :position }
  scope :recent, lambda { order('created_at desc') }
  scope :alphabetical, lambda { order('designs.name, body_styles.name').joins(:design, :body_style) }
  scope :with_body_styles, lambda { |body_styles| where(:body_style_id => [body_styles.map(&:id)]) }
  scope :with_design, lambda { |design| where(:design_id => design.id) }
  scope :inventory_order, lambda { joins(:design, :body_style).order('designs.number', 'body_styles.position') }
  scope :with_image, lambda { joins(:product_images) }
  scope :available, lambda { where(:available => true) }
  scope :shipped_by, lambda { |shipping_facility| where(:shipping_facility => shipping_facility) }
  delegate :age_group, :cut_type, :to => :body_style
  
  validates_uniqueness_of :design_id, :scope => :body_style_id
  
  def is_on_sale?
    body_style.is_on_sale? || design.is_on_sale? || sale_inclusions.applicable.first
  end

  def sale
    is_on_sale?.andand.sale
  end
  
  def name
    name_override.present? ? name_override : design.andand.name.to_s + ' ' + body_style.andand.name.to_s
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
  
  def fulfillment_by_mww?
    product_colors.mww.present?
  end
  
  def generate_code
    self.code = "#{body_style.code}-#{design.number}"
  end
  
  def primary_image size = nil
    if product_images.last
      begin
        primary_image_object.image_url(size)
      rescue ArgumentError
        primary_image_object.image_url
      end
    else
      begin
        art(size)
      rescue ArgumentError
        art
      end
    end
  end
  
  def primary_image_object
    product_images.newest.first
  end
  
  def available_product_colors
    product_colors.available
  end
  
  def landing_product_color
    product_colors.find_by_color_id(landing_color_id) || product_colors.first
  end
  
  def use_base_price
    self.price = body_style.base_price if price.blank?
  end
  
  def use_base_cost
    self.cost = body_style.cost if cost.blank?
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
    elsif (body_style_size = BodyStyleSize.where(:body_style_id => body_style, :size_id => size).first).price.present?
      body_style_size.price / 100.0
    else
      dollar_price
    end
  end
  
  def profit
    price - old_glory_cost
  end
  
  OLD_GLORY_DISCOUNT = 0.10
  def old_glory_cost
    cost.to_f * (1.0 - OLD_GLORY_DISCOUNT)
  end
  
  def garment_cost size, color
    product_color = product_colors.find_by_color_id color
    body_style_size = body_style.body_style_sizes.find_by_size_id size
    stock = product_color.stocks.find_by_body_style_size_id body_style_size
    garment = stock.garments.find_by_design_id design_id rescue nil
    if garment.andand.cost.present?
      garment.cost
    else
      cost
    end
  end
  
  def similar_items
    begin
      ((body_style.products.active.body_style_active +
      Product.active.body_style_active.available.with_body_styles(age_group.andand.body_styles.to_a).with_design(design) +
      Product.active.body_style_active.available.with_body_styles(cut_type.andand.body_styles.to_a).with_design(design) +
      design.products.active.body_style_active.available).uniq - [self]).sort_by { rand }
    rescue StandardError => e
      return []
    end
  end
  
  def default_to_active
    self.active = true
  end
  
  def random_color
    colors.sample
  end
  
  def pin?
    body_style.name.downcase =~ /pin/
  end
  
  def card?
    body_style.name.downcase =~ /card/
  end
  
  def number_in_stock
    inventory_snapshots.sum :current_amount
  end
  
  def stashed?
    stashed_inventories.present?
  end
  
  def number_in_stock_legacy_inventory_system
    inventories.sum :amount
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
  
  def regenerate_existing_image
    puts "about to regenerate image for #{name}"
    generate_image_from_template primary_image_object.andand.image_position_template
    puts "finished regenerating images for #{name}"
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
  
  def feature_color product_color
    if landing_color_id == product_color.color_id
      product_color.add_to_category_features
    end
  end
  
  def deactivate!
    update_attribute :active, false
    ManagerMailer.product_deactivated(id).deliver
  end
end
