class Bulletin < ActiveRecord::Base
  attr_accessible :active, :content, :title, :teaser
  scope :active, where(:active => true)
  scope :alphabetical, order(:title)
  alias_attribute :name, :title
end
