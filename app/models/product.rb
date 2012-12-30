class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  has_many :product_colors
  has_many :product_sizes
  attr_accessible :design_id, :body_style_id, :price, :active, :code, :copy
  scope :active, {:conditions => {:active => true}}
  before_create :use_base_price, :generate_code, :default_to_active
  after_create :create_inventory_in_body_style_sizes
  acts_as_list
  scope :ordered, :order => :position
  
  def name
    design.name + ' ' + body_style.name
  end
  
  def art
    design.art
  end
  
  def generate_code
    self.code = "#{body_style.code}-#{design.number}"
  end
  
  def primary_image
    product_colors.first.andand.product_images.andand.first.andand.image || art
  end
  
  def use_base_price
    self.price = body_style.base_price if price.blank?
  end
  
  def default_to_active
    self.active = true
  end
  
  def create_inventory_in_body_style_sizes
    body_style.sizes.each do |size|
      product_sizes.create :size => size
    end
  end
end
