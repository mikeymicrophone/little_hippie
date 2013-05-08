class OrderMailer < ActionMailer::Base
  def notify_retailer cart
    @cart = cart
    
    mail :to => "taylorswope@littlehippie.com", :subject => "New Order", :from => "sales@littlehippie.com"
  end
end