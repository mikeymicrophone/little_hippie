class OrderMailer < ActionMailer::Base
  def notify_retailer cart, stripe_customer
    @cart = cart
    
    @billing_address = stripe_customer.active_card.name
    @billing_address += "<br>#{stripe_customer.active_card.address_line1}"
    @billing_address += "<br>#{stripe_customer.active_card.address_line2}" if stripe_customer.active_card.address_line2.present?
    @billing_address += "<br>#{stripe_customer.active_card.address_city} #{stripe_customer.active_card.address_zip}"
    @billing_address += "<br>**** **** **** #{stripe_customer.active_card.last4}"
    
    mail :to => [ENV['PRIMARY_RETAILER_RECEIPT_EMAIL'], ENV['BACKUP_RETAILER_RECEIPT_EMAIL']], :subject => "New Order in #{Rails.env}", :from => "little.hippie.messenger@gmail.com"
  end
end
