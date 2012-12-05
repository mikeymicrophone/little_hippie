class Category < ActiveRecord::Base
  has_many :body_style_categorizations, :order => :position
  has_many :body_styles, :through => :body_style_categorizations
  has_many :products, :through => :body_styles
  belongs_to :parent, :class_name => 'Category'
  has_many :children, :class_name => 'Category', :foreign_key => :parent_id
  scope :active, {:conditions => {:active => true}}
  
  attr_accessible :name, :active, :parent_id
end
