class ManagerMailer < ActionMailer::Base
  include Resque::Mailer
  
  def product_deactivated product_id
    @product = Product.find product_id
    
    mail :to => ENV['PRIMARY_RETAILER_RECEIPT_EMAIL'], :subject => "Product deactivated: #{@product.name}"
  end
  
  def wholesale_order_submitted wholesale_order_id
    @wholesale_order = WholesaleOrder.find wholesale_order_id
    
    mail :to => ENV['PRIMARY_RETAILER_RECEIPT_EMAIL'], :subject => "New Wholesale Order"
  end
end
