class BannerTag < ActiveRecord::Base
  belongs_to :banner
  belongs_to :tag, :polymorphic => true
  attr_accessible :active, :tag_id, :tag_type, :banner_id
  validates_uniqueness_of :tag_id, :scope => [:banner_id, :tag_type]
  
  def name
    "#{tag.name} in #{banner.name}" rescue nil
  end
end
