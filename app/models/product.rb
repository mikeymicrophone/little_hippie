class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  has_many :product_colors
  attr_accessible :design_id, :body_style_id, :price, :active, :code, :copy
  scope :active, {:conditions => {:active => true}}
  before_create :use_base_price
  acts_as_list
  scope :ordered, :order => :position
  
  def name
    design.name + ' ' + body_style.name
  end
  
  def art
    design.art
  end
  
  def primary_image
    product_colors.first.andand.product_images.andand.first.andand.image || art
  end
  
  def use_base_price
    self.price = body_style.base_price if price.blank?
  end
end
