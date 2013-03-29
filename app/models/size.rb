class Size < ActiveRecord::Base
  has_many :inventories
  has_many :body_style_sizes
  has_many :body_styles, :through => :body_style_sizes
  has_many :products, :through => :body_styles
  has_many :designs, :through => :products, :uniq => true
  attr_accessible :code, :name
  acts_as_list
  scope :ordered, {:order => 'sizes.position'}
end
