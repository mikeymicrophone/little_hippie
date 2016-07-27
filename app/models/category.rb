class Category < ActiveRecord::Base
  has_many :body_style_categorizations, :order => :position
  has_many :body_styles, :through => :body_style_categorizations, :conditions => ['body_style_categorizations.active = ?', true]
  has_many :products, :through => :body_styles
  has_many :product_colors, :through => :products
  has_many :colors, :through => :product_colors
  has_many :category_images
  has_many :category_product_features, :order => :position
  has_many :featured_products, :through => :category_product_features, :order => 'category_product_features.position', :source => :product_color
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => :parent_id
  has_many :category_pairings
  has_many :content_pages, :through => :category_pairings
  has_many :coupon_categories
  has_many :coupons, :through => :coupon_categories
  scope :active, where(:active => true)
  scope :age_group, where(:is_age_group => true)
  scope :cut_type, where(:is_cut_type => true)
  scope :alphabetical, order(:name)
  
  attr_accessible :name, :active, :has_submenu, :parent_id, :is_age_group, :is_cut_type, :slug
  
  before_create :create_slug
  
  def active_image
    category_images.active.sample
  end
  
  def create_slug
    self.slug ||= name.downcase.gsub(/\s/, '-')
  end
end
