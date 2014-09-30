class WholesaleReceipt < ActionMailer::Base
  include Resque::Mailer
  default from: "little.hippie.messenger@gmail.com"

  def purchase_receipt wholesale_order_id
    @wholesale_order = WholesaleOrder.find wholesale_order_id
    @reseller = @wholesale_order.reseller
    subject = "Receipt for your Little Hippie wholesale order ##{@wholesale_order.id} #{Date.today.strftime('%m/%d/%y')}"
    
    mail :to => @reseller.email, :subject => subject
  end
  
  def quantity_change wholesale_item, requested_quantity
    @requested_quantity = requested_quantity
    @wholesale_item = wholesale_item
    @wholesale_order = @wholesale_item.wholesale_order
    @reseller = @wholesale_order.reseller
    subject = "Little Hippie has revised your order ##{@wholesale_order.id} due to limited inventory."
    
    mail :to => @reseller.email, :subject => subject
  end
end
