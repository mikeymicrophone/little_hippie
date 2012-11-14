class MailingListRegistration < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :street, :street2, :city, :state_id, :zip, :country_id
  validates_uniqueness_of :email, :case_sensitive => false
  before_save :downcase_email
  
  def downcase_email
    self.email = email.downcase
  end
end
