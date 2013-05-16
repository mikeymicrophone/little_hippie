class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller
  protect_from_forgery
  
  helper_method :current_cart, :liked_products
  
  def current_cart(give_to_customer = nil)
    if (@cart = Cart.find_by_id session[:cart_id]).present?
      if give_to_customer
        @cart.update_attribute :customer_id, current_customer.id
      end
    elsif current_customer
      @cart = Cart.create :customer => current_customer
      session[:cart_id] = @cart.id
    end
    @cart
  end
  
  def liked_products
    if current_customer
      current_customer.liked_product_ids
    else
      (session[:liked_product_ids] || []).map(&:to_i)
    end
  end
end
