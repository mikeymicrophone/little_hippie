class State < ActiveRecord::Base
  belongs_to :country
  attr_accessible :country_id, :name, :iso, :id
  scope :alphabetical, lambda { order :name }
  
  def self.connecticut
    find_by :name => 'Connecticut'
  end
end