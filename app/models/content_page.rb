class ContentPage < ActiveRecord::Base
  has_many :category_pairings, :order => :position
  has_many :categories, :through => :category_pairings
  has_many :bulletin_pairings, :order => :position
  has_many :bulletins, :through => :bulletin_pairings
  belongs_to :parent, :class_name => 'ContentPage'
  has_many :children, :class_name => 'ContentPage', :foreign_key => :parent_id
  attr_accessible :title, :slug, :content, :active, :parent_id
  alias_attribute :name, :title
  acts_as_list :scope => :parent_id
  scope :ordered, :order => :position
  
  def self.navigation
    find_by_title 'Navigation'
  end
end
