class Comment < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer
  attr_accessible :message, :moderated_by, :position, :product_id
  
  scope :approved, where('moderated_by is not null')
  scope :ordered, order(:position)
  acts_as_list :scope => :product_id
end
