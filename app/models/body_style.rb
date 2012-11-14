class BodyStyle < ActiveRecord::Base
  has_many :products
  attr_accessible :code, :name
  acts_as_list
  scope :ordered, {:order => 'body_styles.position'}
end
