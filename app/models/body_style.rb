class BodyStyle < ActiveRecord::Base
  has_many :products
  attr_accessible :code, :name
  acts_as_list
  default_scope :order => :position
end
