class WholesaleReceipt < ActionMailer::Base
  include Resque::Mailer
  default from: "little.hippie.messenger@gmail.com"

  def purchase_receipt wholesale_order
    @wholesale_order = wholesale_order
    @reseller = @wholesale_order.reseller
    subject = "Receipt for your Little Hippie wholesale order ##{@wholesale_order.id} #{Date.today.strftime('%m/%d/%y')}"
    
    mail :to => @reseller.email, :subject => subject
  end
end
