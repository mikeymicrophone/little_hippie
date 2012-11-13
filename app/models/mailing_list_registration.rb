class MailingListRegistration < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
end
