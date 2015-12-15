class Link < ActiveRecord::Base
  attr_accessible :display_text, :href, :active, :parent_id
  acts_as_list :scope => :parent_id
  scope :active, lambda { where(:active => true ) }
  scope :ordered, lambda { order(:position) }
end
