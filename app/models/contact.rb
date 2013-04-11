class Contact < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :email, :flagged, :message, :name, :read, :referer, :subject
end
