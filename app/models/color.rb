class Color < ActiveRecord::Base
  has_many :product_colors, :dependent => :destroy
  attr_accessible :code, :name, :css_hex_code
  acts_as_list
  scope :ordered, {:order => 'colors.position'}
  scope :alphabetical, order(:name)
end
