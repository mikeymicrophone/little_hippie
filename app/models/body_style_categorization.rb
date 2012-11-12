class BodyStyleCategorization < ActiveRecord::Base
  belongs_to :body_style
  belongs_to :category
  attr_accessible :active, :position, :body_style_id, :category_id
  acts_as_list :scope => :category_id
end
