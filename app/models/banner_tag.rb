class BannerTag < ActiveRecord::Base
  belongs_to :banner
  belongs_to :tag, :polymorphic => true
  attr_accessible :active, :tag_id, :tag_type, :banner_id
end
