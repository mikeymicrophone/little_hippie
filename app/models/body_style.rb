class BodyStyle < ActiveRecord::Base
  has_many :products
  has_many :body_style_sizes
  has_many :sizes, :through => :body_style_sizes
  attr_accessible :code, :name, :base_price, :image
  mount_uploader :image, ProductImageUploader
  acts_as_list
  scope :ordered, {:order => 'body_styles.position'}
  scope :alphabetical, :order => :name
end
