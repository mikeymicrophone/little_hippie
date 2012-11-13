class Product < ActiveRecord::Base
  belongs_to :design
  belongs_to :body_style
  has_many :product_colors
  attr_accessible :design_id, :body_style_id, :price
  
  def name
    design.name + ' ' + body_style.name
  end
  
  def art
    design.art
  end
  
  def primary_image
    product_colors.first.andand.product_images.andand.first.andand.image
  end
end
