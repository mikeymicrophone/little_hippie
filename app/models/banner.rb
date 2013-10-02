class Banner < ActiveRecord::Base
  has_many :likes, :as => :favorite
  attr_accessible :image, :name, :caption, :link
  
  mount_uploader :image, BannerUploader
end
