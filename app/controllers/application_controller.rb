class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_cart
  
  def current_cart
    if session[:cart_id].present?
      @cart = Cart.find session[:cart_id]
      if current_customer.present?
        unless @cart.customer_id == current_customer.id
          @cart = Cart.create :customer => current_customer
          session[:cart_id] = @cart.id
        end
      end
    else
      @cart = Cart.create :customer => current_customer
      session[:cart_id] = @cart.id
    end
    @cart
  end
  
end
