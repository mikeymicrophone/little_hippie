class SessionsController < Devise::SessionsController
  after_filter :give_cart_if_unclaimed, :only => :create
  before_filter :clear_cart_id, :only => :destroy

  def give_cart_if_unclaimed
    unless current_cart.customer.present?
      current_cart true
    end
  end
  
  def clear_cart_id
    session[:cart_id] = nil
  end
end
