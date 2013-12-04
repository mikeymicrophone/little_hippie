class Banner < ActiveRecord::Base
  has_many :likes, :as => :favorite
  attr_accessible :image, :name, :caption, :link, :position, :active_in_gallery
  scope :recent, order('created_at desc')
  scope :in_gallery, where(:active_in_gallery => true)
  acts_as_list :scope => "name = '#{name}'"
  
  mount_uploader :image, BannerUploader
end
