class Size < ActiveRecord::Base
  has_many :inventories
  attr_accessible :code, :name
  acts_as_list
  scope :ordered, {:order => 'sizes.position'}
end
