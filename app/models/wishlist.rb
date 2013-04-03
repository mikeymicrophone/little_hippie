class Wishlist < ActiveRecord::Base
  belongs_to :customer
  has_many :wishlist_items
  attr_accessible :name, :customer_id, :customer
end
