class Bulletin < ActiveRecord::Base
  attr_accessible :active, :content, :title
  scope :active, {:conditions => {:active => true}}
  alias_attribute :name, :title
end
