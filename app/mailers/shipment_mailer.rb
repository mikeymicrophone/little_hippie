class ShipmentMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "support@littlehippie.com"
  
  def shipment_tracking cart_id
    @cart = Cart.find cart_id
    @customer = @cart.customer
    @shipping_address = @cart.apparent_primary_shipping_address
    @shipping_provider = @cart.shipping_method == Cart::STANDARD_SHIPPING ? 'USPS' : 'UPS'
    mail :to => [@shipping_address.email, @customer.andand.email].compact.uniq, :subject => 'Tracking # for your Little Hippie Order'
  end
  
  def gift_message cart_id
    @cart = Cart.find cart_id
    @customer = @cart.customer
    @shipping_provider = @cart.shipping_method == Cart::STANDARD_SHIPPING ? 'USPS' : 'UPS'
    
    mail :to => @friend_email.email, :subject => @subject
  end
end
