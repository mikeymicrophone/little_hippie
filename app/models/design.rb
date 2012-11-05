class Design < ActiveRecord::Base
  attr_accessible :art, :name, :number
  
  mount_uploader :art, ArtworkUploader
end
