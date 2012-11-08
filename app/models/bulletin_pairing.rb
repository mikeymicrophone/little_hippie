class BulletinPairing < ActiveRecord::Base
  belongs_to :bulletin
  belongs_to :content_page
  attr_accessible :position, :bulletin_id, :content_page_id
  acts_as_list :scope => :content_page_id
end
