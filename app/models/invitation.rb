class Invitation < ActiveRecord::Base
  attr_accessible :approved_at, :email, :invited_by_email, :invited_by_name, :name, :note, :code
  
  after_create :deliver_admin_notification
  
  scope :approved, lambda { where('approved_at is not null') }
  
  def approve!
    code = ""
    loop do
      code = ""
      7.times do
        code << ('A'..'Z').to_a.sample
      end
      break unless Invitation.find_by_code code
    end
    update_attributes :approved_at => Time.now, :code => code
  end
  
  def deliver_admin_notification
    InvitationMailer.beta_invitation_requested(id).deliver
  end
end
