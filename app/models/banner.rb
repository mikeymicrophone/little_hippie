class Banner < ActiveRecord::Base
  has_many :likes, :as => :favorite
  attr_accessible :image, :name, :caption, :link, :position, :active_in_gallery, :gallery_position
  scope :recent, order('created_at desc')
  scope :in_gallery, where(:active_in_gallery => true)
  scope :ordered, order(:gallery_position)
  acts_as_list :column => :gallery_position
  
  mount_uploader :image, BannerUploader
end
