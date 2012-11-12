class Category < ActiveRecord::Base
  has_many :body_style_categorizations, :order => :position
  has_many :body_styles, :through => :body_style_categorizations
  has_many :products, :through => :body_styles
  
  attr_accessible :name
end
