class OrderMailer < ActionMailer::Base
  def notify_retailer cart
    @cart = cart
    
    mail :to => "info@littlehippie.com", :subject => "New Order"
  end
end