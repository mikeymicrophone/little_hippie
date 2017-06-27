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
  has_many :banner_tags, :as => :tag
  attr_accessible :art, :name, :number, :background_color, :fabric_photo
  attr_default :background_color, 'ffffff'
  
  after_create :feature!
  
  mount_uploader :art, ArtworkUploader
  mount_uploader :fabric_photo, FabricPhotoMasterUploader
  acts_as_list
  scope :ordered, lambda { order 'designs.position' }
  scope :recent, lambda { order('created_at desc') }
  scope :alphabetical, lambda { order :name }
  scope :featured, lambda { joins(:design_features).order('design_features.position').merge(DesignFeature.current) }
  scope :unfeatured, lambda { joins('left join design_features on design_features.design_id = designs.id').where('design_features.id is null') }
  scope :liked, lambda { joins(:likes).group('designs.id').order('count(likes.id) desc') }
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
  
  def regenerate_all_product_images
    products.each &:regenerate_existing_image
  end
  
  def feature!
    move_to_top
    feature = design_features.create :active_from => (Date.today - 1.day), :active_until => 3.years.from_now, :business_manager_id => 3
    feature.move_to_top
  end
end
