class Bulletin < ActiveRecord::Base
  has_many :bulletin_pairings, :dependent => :destroy
  attr_accessible :active, :content, :title, :teaser, :created_at
  scope :active, where(:active => true)
  scope :alphabetical, order(:title)
  alias_attribute :name, :title
  validates_uniqueness_of :content
  validates_presence_of :content
end
