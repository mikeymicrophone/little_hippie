class Background < ActiveRecord::Base
  attr_accessible :image, :name, :active
  mount_uploader :image, BannerUploader
  
  after_save :only_one_is_active
  
  def only_one_is_active
    if active?
      Background.where('id != ?', id).update_all :active => false
    end
  end
  
  def self.active
    where(:active => true).first
  end
end
