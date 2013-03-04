class CategoryProductFeature < ActiveRecord::Base
  belongs_to :category
  belongs_to :product_color
  attr_accessible :position, :category_id, :product_color_id
  
  acts_as_list :scope => :category_id
end
