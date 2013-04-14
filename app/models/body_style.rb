class BodyStyle < ActiveRecord::Base
  has_many :products
  has_many :designs, :through => :products
  has_many :product_colors, :through => :products
  has_many :colors, :through => :product_colors, :uniq => true
  has_many :body_style_sizes, :order => :position
  has_many :sizes, :through => :body_style_sizes, :order => 'body_style_sizes.position'
  has_many :body_style_categorizations
  has_many :categories, :through => :body_style_categorizations, :conditions => ['body_style_categorizations.active = ?', true]
  has_many :body_style_product_features
  has_many :featured_products, :through => :body_style_product_features, :source => :product_color
  attr_accessible :code, :name, :base_price, :image, :xxl_price, :xxxl_price
  mount_uploader :image, ProductImageUploader
  acts_as_list
  scope :ordered, {:order => 'body_styles.position'}
  scope :alphabetical, :order => :name
  scope :without_design, lambda { |design| select('body_styles.*').uniq.joins('left outer join products on products.body_style_id = body_styles.id left outer join designs on products.design_id = designs.id').where('body_styles.id not in (select products.body_style_id from products where products.design_id = ?)', design.id) }
  scope :with_designs, joins(:designs)
  scope :without_any_designs, joins('left outer join products on products.body_style_id = body_styles.id left outer join designs on products.design_id = designs.id').where('designs.id is null').uniq
  paginates_per 8

  def to_param
    "#{id}-#{name_without_spaces}"
  end
  
  def name_without_spaces
    name.gsub(/[\s\']/, '-')
  end
    
  def remaining_products
    (product_colors - featured_products).sort_by { rand }
  end
  
  def age_group
    categories.age_group.first
  end
  
  def cut_type
    categories.cut_type.first
  end
end
