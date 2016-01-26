class ArtworkImage < ActiveRecord::Base
  belongs_to :garment
  has_one :size, :through => :garment
  attr_accessible :active, :fabric_photo, :garment_id, :name
  mount_uploader :fabric_photo, FabricPhotoMasterUploader
  delegate :product, :to => :garment
  scope :for_size, lambda { |size| joins(:garment).merge(Garment.of_size(size.id)) }
  scope :active, lambda { where(:active => true) }
  attr_default :active, true
end
