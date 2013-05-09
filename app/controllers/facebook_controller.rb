class FacebookController < ApplicationController
  def new_session
    current_facebook_user.fetch
    
    if (@customer = Customer.find_by_email current_facebook_user.email)
      @customer.update_attribute(:facebook_id, current_facebook_user.id) if @customer.facebook_id.blank?
      sign_in @customer
      redirect_to root_url
    else
      # Invitation.create :email => current_facebook_user.email, :name => current_facebook_user.name, :note => 'Used Facebook Connect'
      # render :action => 'beta_account_requested', :layout => 'customer'
      # above is the 'private beta' logic. below is the 'public beta' logic.
      @customer = Customer.create :email => current_facebook_user.email, :facebook_id => current_facebook_user.id
      sign_in @customer
      redirect_to root_url
    end
  end
end
