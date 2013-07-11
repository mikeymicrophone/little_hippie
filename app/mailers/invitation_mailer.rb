class InvitationMailer < ActionMailer::Base
  def beta_invitation_approved invitation
    @invitation = invitation
    mail :to => invitation.email, :subject => "Your invitation to Little Hippie®'s private beta has been approved", :from => 'beta@littlehippie.com'
  end
  
  def beta_invitation_requested invitation
    @invitation = invitation
    mail :to => 'beta@littlehippie.com', :subject => 'Beta account requested', :from => 'beta@littlehippie.com'
  end
end
