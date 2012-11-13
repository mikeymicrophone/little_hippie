class Design < ActiveRecord::Base
  attr_accessible :art, :name, :number
  
  mount_uploader :art, ArtworkUploader
  acts_as_list
  default_scope :order => :position
end
