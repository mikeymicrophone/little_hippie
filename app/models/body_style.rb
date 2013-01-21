class BodyStyle < ActiveRecord::Base
  has_many :products
  has_many :body_style_sizes, :order => :position
  has_many :sizes, :through => :body_style_sizes, :order => 'body_style_sizes.position'
  attr_accessible :code, :name, :base_price, :image
  mount_uploader :image, ProductImageUploader
  acts_as_list
  scope :ordered, {:order => 'body_styles.position'}
  scope :alphabetical, :order => :name
end
