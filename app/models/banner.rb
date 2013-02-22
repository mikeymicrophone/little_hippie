class Banner < ActiveRecord::Base
  attr_accessible :image, :name
  
  mount_uploader :image, BannerUploader
end
