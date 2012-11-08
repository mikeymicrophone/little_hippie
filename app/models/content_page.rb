class ContentPage < ActiveRecord::Base
  has_many :category_pairings, :order => :position
  has_many :categories, :through => :category_pairings
  has_many :bulletin_pairings, :order => :position
  has_many :bulletins, :through => :bulletin_pairings
  # attr_accessible :title, :body
  alias_attribute :name, :title
end
