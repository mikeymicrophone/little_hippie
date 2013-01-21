class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  has_many :product_colors, :dependent => :destroy
  has_many :colors, :through => :product_colors
  has_many :sizes, :through => :body_style
  attr_accessible :design_id, :body_style_id, :price, :active, :code, :copy
  scope :active, {:conditions => {:active => true}}
  before_create :use_base_price, :generate_code, :default_to_active
  acts_as_list
  scope :ordered, :order => :position
  scope :alphabetical, order('designs.name, body_styles.name').joins(:design, :body_style)
  
  def name
    design.name + ' ' + body_style.name
  end
  
  def art size = nil
    design.art_url size
  end
  
  def generate_code
    self.code = "#{body_style.code}-#{design.number}"
  end
  
  def primary_image size = nil
    product_colors.first.andand.product_images.andand.first.andand.image || art(size)
  end
  
  def use_base_price
    self.price = body_style.base_price if price.blank?
  end
  
  def dollar_price
    price.andand./(100)
  end
  
  def similar_items
    body_style.products.except(self)[0..3]
  end
  
  def default_to_active
    self.active = true
  end
  
  def random_color
    colors.sample
  end
end
