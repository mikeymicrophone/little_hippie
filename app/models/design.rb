class Design < ActiveRecord::Base
  has_many :products
  has_many :body_styles, :through => :products
  has_many :product_colors, :through => :products
  has_many :colors, :through => :product_colors, :uniq => true
  has_many :design_features
  has_many :unit_prices
  has_many :garments
  has_many :likes, :as => :favorite
  has_many :sale_inclusions, :as => :inclusion
  attr_accessible :art, :name, :number, :background_color
  
  mount_uploader :art, ArtworkUploader
  acts_as_list
  scope :ordered, {:order => 'designs.position'}
  scope :alphabetical, :order => :name
  scope :featured, joins(:design_features).order('design_features.position')
  scope :unfeatured, joins('left join design_features on design_features.design_id = designs.id').where('design_features.id is null')
  scope :liked, joins(:likes).group('designs.id').order('count(likes.id) desc')
  paginates_per 8
  
  def is_on_sale?
    sale_inclusions.applicable.first
  end
  
  def url_name
    name.gsub(/[\s\?\'\/]/, '-')
  end
  
  def to_param
    "#{id}-#{url_name}"
  end
end
