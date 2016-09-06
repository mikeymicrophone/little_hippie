class MailingListRegistration < ActiveRecord::Base
  belongs_to :referral
  attr_accessible :email, :first_name, :last_name, :street, :street2, :city, :state, :zip, :festival, :referral_id
  validates_uniqueness_of :email, :case_sensitive => false
  before_save :downcase_email
  after_save :send_to_mailchimp
  
  def downcase_email
    self.email = email.downcase
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
  
  def send_to_mailchimp
    begin
      gibbon = Gibbon::Request.new :api_key => ENV['MAILCHIMP_API_KEY']
      mail_list = gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.create :body => {:email_address => email, :status => 'subscribed', merge_fields: {FNAME: first_name, LNAME: last_name}}
    rescue Gibbon::MailChimpError => mail_error
      Rails.logger.info mail_error
    end
  end
end
