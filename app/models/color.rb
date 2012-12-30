class Color < ActiveRecord::Base
  attr_accessible :code, :name
  acts_as_list
  scope :ordered, {:order => 'colors.position'}
  scope :alphabetical, order(:name)
end
