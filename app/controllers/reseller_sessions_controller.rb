class ResellerSessionsController < Devise::SessionsController
  before_filter :clear_wholesale_order_id, :only => :destroy
  
  def clear_wholesale_order_id
    session[:current_wholesale_order_id] = nil
  end
  
  def after_sign_in_path_for resource
    styles_wholesale_orders_path
  end
end
