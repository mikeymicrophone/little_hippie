class BodyStyle < ActiveRecord::Base
  has_many :products
  attr_accessible :code, :name
end
