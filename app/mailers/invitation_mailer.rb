class InvitationMailer < ActionMailer::Base
  include Resque::Mailer
  
  def beta_invitation_approved invitation_id
    @invitation = Invitation.find invitation_id
    mail :to => @invitation.email, :subject => "Your invitation to Little Hippie's private beta has been approved", :from => 'beta@littlehippie.com'
  end
  
  def beta_invitation_requested invitation_id
    @invitation = Invitation.find invitation_id
    mail :to => 'beta@littlehippie.com', :subject => 'Beta account requested', :from => 'beta@littlehippie.com'
  end
end
