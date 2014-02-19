class State < ActiveRecord::Base
  belongs_to :country
  attr_accessible :country_id, :name, :iso, :id
  scope :alphabetical, {:order => 'name'}
  
  def self.connecticut
    find_by_name('Connecticut')
  end
end