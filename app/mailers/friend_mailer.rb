class FriendMailer < ActionMailer::Base
  default from: "support@littlehippie.com"
  
  def product_suggestion friend_email
    if friend_email.customer
      @subject = "#{friend_email.customer.name} has a suggestion for you on LittleHippie.com"
      @from = friend_email.customer.email
    else
      @subject = "Your friend suggested a product from LittleHippie.com"
      @from = "support@littlehippie.com"
    end
    @product = friend_email.product
    @message = friend_email.message
    
    mail :to => friend_email.email, :subject => @subject, :from => @from#, :cc => 'friend-emails@littlehippie.com'
  end
end
