class Design < ActiveRecord::Base
  has_many :products
  has_many :body_styles, :through => :products
  has_many :product_colors, :through => :products
  has_many :colors, :through => :product_colors, :uniq => true
  has_many :design_features
  attr_accessible :art, :name, :number, :background_color
  
  mount_uploader :art, ArtworkUploader
  acts_as_list
  scope :ordered, {:order => 'designs.position'}
  scope :alphabetical, :order => :name
  scope :featured, joins(:design_features).order('design_features.position')
  scope :unfeatured, joins('left join design_features on design_features.design_id = designs.id').where('design_features.id is null')
  paginates_per 8
end
