class ResellersController < ApplicationController
  before_filter :authenticate_reseller!, :only => [:specify_tax_id, :update_tax_id, :home]
  before_filter :authenticate_product_manager!, :only => [:index, :show, :edit, :update]
  before_filter :authenticate_business_manager!, :only => [:authorize, :deauthorize]
  
  def home
    @reseller = current_reseller
    render :layout => 'customer'
  end
  
  def index
    @resellers = Reseller.all
  end
  
  def show
    @reseller = Reseller.find params[:id]
  end
  
  def edit
    @reseller = Reseller.find params[:id]
  end
  
  def update
    @reseller = Reseller.find params[:id]
    @reseller.update_attributes params[:reseller]
    redirect_to @reseller
  end

  def specify_tax_id
    render :layout => 'customer'
  end
  
  def update_tax_id
    current_reseller.update_attributes params[:reseller]
    redirect_to styles_wholesale_orders_path, :notice => "Thanks! Go ahead and place an order. We'll review it before charging you."
  end
  
  def authorize
    @reseller = Reseller.find params[:id]
    @reseller.authorized = true
    @reseller.save
    ResellerMailer.authorized_to_order(@reseller.id).deliver
    redirect_to resellers_path
  end
  
  def deauthorize
    @reseller = Reseller.find params[:id]
    @reseller.authorized = false
    @reseller.save
    redirect_to resellers_path    
  end
  
  def enter_credit_card
    render :layout => 'customer'
  end
  
  def save_credit_card
    @reseller = current_reseller
    customer = Stripe::Customer.create :card => params[:stripe_id], :email => @reseller.email, :description => "Reseller #{@reseller.id}"
    @reseller.stripe_customer_id = customer.id
    @reseller.save
    render :layout => 'customer'
  end
end
