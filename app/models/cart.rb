class Cart < ActiveRecord::Base
  belongs_to :customer
  has_many :items
  attr_accessible :status, :customer
end
