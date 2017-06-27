class Bulletin < ActiveRecord::Base
  has_many :bulletin_pairings, :dependent => :destroy
  has_many :content_pages, :through => :bulletin_pairings
  has_many :likes, :as => :favorite, :dependent => :destroy
  belongs_to :banner
  attr_accessible :active, :content, :title, :teaser, :created_at, :facebook_post_id, :facebook_image_url, :og_type, :og_url, :show_more
  scope :active, lambda { where(:active => true) }
  scope :alphabetical, lambda { order(:title) }
  scope :recent, lambda { order('created_at desc') }
  alias_attribute :name, :title
  validates_uniqueness_of :content, :facebook_post_id, :allow_nil => true
  validates_presence_of :content
  
  def update_facebook_data
    return nil unless facebook_post_id?
    client = Mogli::Client.new(ENV['FACEBOOK_API_TOKEN'])
    facebook_post = Mogli::Post.find(facebook_post_id, client)
    self.og_type = facebook_post.type
    self.og_url = facebook_post.link
    self.facebook_image_url = facebook_post.picture.andand.gsub('_s.jpg', '_n.jpg')
    save
    
    unless Banner.find_by_image(facebook_image_url)
      banner = Banner.new :name => 'Facebook Posted Image'
      banner.remote_image_url = facebook_image_url
      banner.save
    end
    
  end
end
