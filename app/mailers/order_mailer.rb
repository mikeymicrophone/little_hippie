class OrderMailer < ActionMailer::Base
  def notify_retailer cart, stripe_customer
    @cart = cart
    
    @billing_address = stripe_customer.active_card.name
    @billing_address += "<br>#{stripe_customer.active_card.address_line1}"
    @billing_address += "<br>#{stripe_customer.active_card.address_line2}" if stripe_customer.active_card.address_line2.present?
    @billing_address += "<br>#{stripe_customer.active_card.address_city} #{stripe_customer.active_card.address_zip}"
    @billing_address += "<br>**** **** **** #{stripe_customer.active_card.last4}"
    
    mail :to => "taylorswope@littlehippie.com", :subject => "New Order", :from => "admin@littlehippie.com"
  end
end