class ContactMailer < ActionMailer::Base
  include Resque::Mailer
  
  def contact_form_submission contact_id
    @contact = Contact.find contact_id
    if @contact.email.present? && @contact.email =~ /^[\w\d_.+-]+@[\w\d-]+\.[\w\d-.]+$/
      @from = @contact.email
    else
      @from = "support@littlehippie.com"
    end
    
    if @contact.subject.present?
      @subject = @contact.subject
    else
      @subject = 'Contact Form Submission'
    end
    
    @name = @contact.name
    @message = @contact.message
    
    mail :to => 'contact@littlehippie.com', :subject => @subject, :from => @from
  end
end