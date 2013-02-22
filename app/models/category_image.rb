class CategoryImage < ActiveRecord::Base
  belongs_to :category
  attr_accessible :display_end, :display_start, :image, :category_id
  
  mount_uploader :image, BannerUploader
  
  scope :active, lambda { where("display_start < ? and display_end > ?", Time.now, Time.now) }
end
