class CategoryPairing < ActiveRecord::Base
  belongs_to :category
  belongs_to :content_page
  attr_accessible :position, :category_id, :content_page_id
  acts_as_list :scope => :content_page_id
end
