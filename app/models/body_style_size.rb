class BodyStyleSize < ActiveRecord::Base
  belongs_to :body_style
  belongs_to :size
  attr_accessible :size_id, :body_style_id
  scope :ordered, order(:position)
  acts_as_list
end
