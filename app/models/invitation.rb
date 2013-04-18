class Invitation < ActiveRecord::Base
  attr_accessible :approved_at, :email, :invited_by_email, :invited_by_name, :name, :note
  
  scope :approved, where('approved_at is not null')
end
