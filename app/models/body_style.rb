class BodyStyle < ActiveRecord::Base
  has_many :products
  has_many :designs, :through => :products
  has_many :product_colors, :through => :products
  has_many :colors, :through => :product_colors, :uniq => true
  has_many :body_style_sizes, :order => :position
  has_many :sizes, :through => :body_style_sizes, :order => 'body_style_sizes.position'
  has_many :body_style_categorizations
  has_many :categories, :through => :body_style_categorizations
  has_many :body_style_product_features
  has_many :featured_products, :through => :body_style_product_features, :source => :product_color
  attr_accessible :code, :name, :base_price, :image
  mount_uploader :image, ProductImageUploader
  acts_as_list
  scope :ordered, {:order => 'body_styles.position'}
  scope :alphabetical, :order => :name
  scope :without_design, lambda { |design| select('body_styles.*').uniq.joins(:designs).where('body_styles.id not in (select products.body_style_id from products where products.design_id = ?)', design.id) }
  paginates_per 8
  
  def age_group
    categories.age_group.first
  end
  
  def cut_type
    categories.cut_type.first
  end
end
