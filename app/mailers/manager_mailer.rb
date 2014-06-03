class ManagerMailer < ActionMailer::Base
  include Resque::Mailer
  
  def product_deactivated product_id
    @product = Product.find product_id
    
    mail :to => ENV['PRIMARY_RETAILER_RECEIPT_EMAIL'], :subject => "Product deactivated: #{@product.name}"
  end
end
