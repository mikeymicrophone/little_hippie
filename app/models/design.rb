class Design < ActiveRecord::Base
  has_many :products
  has_many :body_styles, :through => :products
  attr_accessible :art, :name, :number
  
  mount_uploader :art, ArtworkUploader
  acts_as_list
  default_scope :order => 'designs.position'
end
