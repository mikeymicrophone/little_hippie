class ResellerMailer < ActionMailer::Base
  include Resque::Mailer
  
  def authorized_to_order reseller_id
    @reseller = Reseller.find reseller_id

    mail :to => @reseller.email, :subject => "Your Reseller Account is authorized to purchase from Little Hippie!", :from => "little.hippie.messenger@gmail.com"
  end
  
  def deauthorized_from_ordering reseller_id
    
  end
end
