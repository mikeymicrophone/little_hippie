class Banner < ActiveRecord::Base
  has_many :likes, :as => :favorite
  has_many :banner_tags
  attr_accessible :image, :name, :caption, :link, :position, :active_in_gallery, :gallery_position, :customer_uploaded
  scope :recent, order('created_at desc')
  scope :in_gallery, where(:active_in_gallery => true)
  scope :ordered, order(:gallery_position)
  scope :not_from_customers, where(:customer_uploaded => nil)
  scope :from_customers, where(:customer_uploaded => true)
  scope :trivial, where("1 = 1")
  acts_as_list :column => :gallery_position
  attr_default :active_in_gallery, false
  
  after_save :manage_gallery_ordering
  
  mount_uploader :image, BannerUploader
  
  def manage_gallery_ordering
    if active_in_gallery_changed?
      if active_in_gallery?
        insert_at
      else
        remove_from_list
      end
    end
  end
  
  def last_tagged_product
    banner_tags.last.andand.tag
  end
end
