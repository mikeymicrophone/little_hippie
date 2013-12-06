class Contact < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :email, :flagged, :message, :name, :read, :referer, :subject
  
  scope :recent, order('created_at desc')
  
  after_create :deliver_to_admin
  
  def deliver_to_admin
    ContactMailer.contact_form_submission(id).deliver
  end
end
