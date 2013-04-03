class Banner < ActiveRecord::Base
  attr_accessible :image, :name, :caption
  
  mount_uploader :image, BannerUploader
end
