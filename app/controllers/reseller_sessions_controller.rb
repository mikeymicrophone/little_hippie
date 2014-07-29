class ResellerSessionsController < Devise::SessionsController
  before_filter :clear_wholesale_order_id, :only => :destroy
  
  def clear_wholesale_order_id
    session[:current_wholesale_order_id] = nil
  end
end
