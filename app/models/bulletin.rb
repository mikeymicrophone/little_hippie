class Bulletin < ActiveRecord::Base
  attr_accessible :active, :content, :title, :teaser
  scope :active, where(:active => true)
  scope :alphabetical, order(:title)
  alias_attribute :name, :title
  validates_uniqueness_of :content
  validates_presence_of :content
end
