class State < ActiveRecord::Base
  belongs_to :country
  attr_accessible :country_id, :name, :iso, :id
  scope :alphabetical, {:order => 'name'}
end