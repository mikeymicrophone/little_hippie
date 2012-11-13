class Color < ActiveRecord::Base
  attr_accessible :code, :name
  acts_as_list
  default_scope :order => 'colors.position'
end
