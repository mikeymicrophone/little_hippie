class Category < ActiveRecord::Base
  has_many :body_style_categorizations, :order => :position
  has_many :body_styles, :through => :body_style_categorizations
  has_many :products, :through => :body_styles
  has_many :category_images
  has_many :category_product_features, :order => :position
  has_many :featured_products, :through => :category_product_features, :order => 'category_product_features.position', :source => :product_color
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => :parent_id
  scope :active, where(:active => true)
  scope :age_group, where(:is_age_group => true)
  scope :cut_type, where(:is_cut_type => true)
  
  attr_accessible :name, :active, :parent_id, :is_age_group, :is_cut_type
  
  def active_image
    category_images.active.sample
  end
end
