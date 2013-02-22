class CategoryImage < ActiveRecord::Base
  belongs_to :category
  attr_accessible :display_end, :display_start, :image, :category_id
  
  mount_uploader :image, BannerUploader
end
