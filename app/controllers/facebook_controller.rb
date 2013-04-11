class FacebookController < ApplicationController
  def new_session
    current_facebook_user.fetch
    
    if (@customer = Customer.find_by_email current_facebook_user.email)
      @customer.update_attribute(:facebook_id, current_facebook_user.id) if @customer.facebook_id.blank?
    else
      @customer = Customer.create :email => current_facebook_user.email, :facebook_id => current_facebook_user.id
    end
    
    sign_in @customer
    redirect_to root_url
  end
end
