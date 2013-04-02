class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  has_many :categories, :through => :body_style
  has_many :product_colors, :dependent => :destroy
  has_many :product_images, :through => :product_colors
  has_many :colors, :through => :product_colors
  has_many :sizes, :through => :body_style
  attr_accessible :design_id, :body_style_id, :price, :active, :code, :copy
  scope :active, {:conditions => {:active => true}}
  before_create :use_base_price, :generate_code, :default_to_active
  acts_as_list
  scope :ordered, :order => :position
  scope :alphabetical, order('designs.name, body_styles.name').joins(:design, :body_style)
  scope :with_body_styles, lambda { |body_styles| where(:body_style_id => [body_styles.map(&:id)]) }
  scope :with_design, lambda { |design| where(:design_id => design.id) }
  delegate :age_group, :cut_type, :to => :body_style
  
  define_index do
    indexes design.name
    indexes design.number
    indexes body_style.name
    indexes body_style.code
    indexes code
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
        product_images.last.image_url(size)
      rescue ArgumentError
        product_images.last.image_url
      end
    else
      begin
        art(size)
      rescue ArgumentError
        art
      end
    end
  end
  
  def use_base_price
    self.price = body_style.base_price if price.blank?
  end
  
  def dollar_price
    price.andand./(100)
  end
  
  def similar_items
    (body_style.products.except(self) +
    Product.with_body_styles(age_group.andand.body_styles.to_a).with_design(design) +
    Product.with_body_styles(cut_type.andand.body_styles.to_a).with_design(design) +
    design.products).uniq
  end
  
  def default_to_active
    self.active = true
  end
  
  def random_color
    colors.sample
  end
end
