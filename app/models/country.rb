class Country < ActiveRecord::Base
  has_many :states
  attr_accessible :iso, :name, :id
  scope :alphabetical, lambda { order('name') }
  
  def self.united_states
    find_by_name('United States')
  end

  def self.canada
    find_by_name('Canada')
  end
end
