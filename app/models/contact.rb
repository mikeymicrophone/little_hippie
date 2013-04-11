class Contact < ActiveRecord::Base
  attr_accessible :email, :flagged, :message, :name, :read, :referer, :subject
end
