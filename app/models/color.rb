class Color < ActiveRecord::Base
  attr_accessible :code, :name, :css_hex_code
  acts_as_list
  scope :ordered, {:order => 'colors.position'}
  scope :alphabetical, order(:name)
end
