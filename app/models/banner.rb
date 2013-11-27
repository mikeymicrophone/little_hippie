class Banner < ActiveRecord::Base
  has_many :likes, :as => :favorite
  attr_accessible :image, :name, :caption, :link
  scope :recent, order('created_at desc')
  
  mount_uploader :image, BannerUploader
end
