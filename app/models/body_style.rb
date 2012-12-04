class BodyStyle < ActiveRecord::Base
  has_many :products
  attr_accessible :code, :name, :base_price
  acts_as_list
  scope :ordered, {:order => 'body_styles.position'}
  scope :alphabetical, :order => :name
end
