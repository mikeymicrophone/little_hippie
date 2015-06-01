class ContentPage < ActiveRecord::Base
  has_many :category_pairings, :order => :position
  has_many :categories, :through => :category_pairings, :order => 'category_pairings.position'
  has_many :bulletin_pairings, :order => :position
  has_many :bulletins, :through => :bulletin_pairings, :order => 'bulletin_pairings.position'
  belongs_to :parent, :class_name => 'ContentPage'
  has_many :children, :class_name => 'ContentPage', :foreign_key => :parent_id
  attr_accessible :title, :slug, :content, :active, :parent_id, :html_title, :show_children
  alias_attribute :name, :title
  acts_as_list :scope => :parent_id
  scope :ordered, :order => :position
  scope :active, where(:active => true)
  scope :alphabetical, order(:title)
  
  def self.navigation
    locate 'Navigation'
  end
  
  def self.about_us
    locate 'ABOUT US'
  end
  
  def self.taylors_story
    locate "Taylor's Story"
  end

  def self.locate title
    page = find_by_title title
    page ||= first
  end
end
