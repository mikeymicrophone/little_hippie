class Color < ActiveRecord::Base
  has_many :product_colors, :dependent => :destroy
  has_many :products, :through => :product_colors, :uniq => true
  has_many :body_styles, :through => :products, :uniq => true
  has_many :designs, :through => :products, :uniq => true
  attr_accessible :code, :name, :css_hex_code
  acts_as_list
  scope :ordered, {:order => 'colors.position'}
  scope :alphabetical, order(:name)
  paginates_per 20
end
