class Country < ActiveRecord::Base
  has_many :states
  attr_accessible :iso, :name, :id
  scope :alphabetical, {:order => 'name'}
  
  def self.united_states
    find_by_name('United States')
  end
end