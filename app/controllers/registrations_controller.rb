class RegistrationsController < Devise::RegistrationsController
  after_filter :give_cart_if_claimed, :only => :create
  
  def give_cart_if_claimed
    if params[:claim_cart]
      current_cart current_customer
    end
  end
end