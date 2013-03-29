class Design < ActiveRecord::Base
  has_many :products
  has_many :body_styles, :through => :products
  has_many :product_colors, :through => :products
  attr_accessible :art, :name, :number, :background_color
  
  mount_uploader :art, ArtworkUploader
  acts_as_list
  scope :ordered, {:order => 'designs.position'}
  scope :alphabetical, :order => :name
  paginates_per 8
end
