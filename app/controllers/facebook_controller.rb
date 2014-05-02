class FacebookController < ApplicationController
  def new_session
    current_facebook_user.fetch
    session[:facebook_access_token] = current_facebook_user.client.access_token
    
    if (@customer = Customer.find_by_email current_facebook_user.email)
      @customer.update_attribute(:facebook_id, current_facebook_user.id) if @customer.facebook_id.blank?
      sign_in @customer
    else
      @customer = Customer.create :email => current_facebook_user.email, :facebook_id => current_facebook_user.id
      sign_in @customer
    end
  end
end
