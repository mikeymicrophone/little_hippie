class Banner < ActiveRecord::Base
  has_many :likes, :as => :favorite
  has_many :banner_tags
  attr_accessible :image, :name, :caption, :link, :position, :active_in_gallery, :gallery_position
  scope :recent, order('created_at desc')
  scope :in_gallery, where(:active_in_gallery => true)
  scope :ordered, order(:gallery_position)
  acts_as_list :column => :gallery_position
  
  after_save :manage_gallery_ordering
  
  mount_uploader :image, BannerUploader
  
  define_index do
    indexes name
  end
  
  def manage_gallery_ordering
    if active_in_gallery_changed?
      if active_in_gallery?
        insert_at
      else
        remove_from_list
      end
    end
  end
end
