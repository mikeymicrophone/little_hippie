class Bulletin < ActiveRecord::Base
  has_many :bulletin_pairings, :dependent => :destroy
  has_many :content_pages, :through => :bulletin_pairings
  has_many :likes, :as => :favorite, :dependent => :destroy
  attr_accessible :active, :content, :title, :teaser, :created_at, :facebook_post_id, :facebook_image_url, :og_type, :og_url
  scope :active, where(:active => true)
  scope :alphabetical, order(:title)
  alias_attribute :name, :title
  validates_uniqueness_of :content, :facebook_post_id, :allow_nil => true
  validates_presence_of :content
end
