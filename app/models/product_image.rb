class ProductImage < ActiveRecord::Base
  belongs_to :product_color
  belongs_to :image_position_template
  attr_accessible :image, :product_color_id, :image_position_template, :image_position_template_id
  mount_uploader :image, ProductImageUploader
  delegate :name, :to => :product_color, :allow_nil => true
  
  scope :newest, lambda { order('created_at desc').limit(1) }
end
