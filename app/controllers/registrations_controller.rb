class RegistrationsController < Devise::RegistrationsController
  after_filter :give_cart_if_claimed, :only => :create

  def update_screen
    respond_to do |format|
      format.js
    end
  end
  
  def give_cart_if_claimed
    if params[:claim_cart]
      current_cart current_customer
    end
  end
  
  def after_sign_up_path_for resource
    if resource.is_a? Customer
      {:controller => 'registrations', :action => 'update_screen'}
    elsif resource.is_a? Reseller
      {:controller => 'resellers', :action => 'specify_tax_id', :id => resource.id}
    end
  end
  
  def after_sign_in_path_for resource
    if resource.is_a? Reseller
      {:controller => 'wholesale_orders', :action => 'styles'}
    end
  end
  
end
