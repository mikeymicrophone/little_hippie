class ResellersController < ApplicationController
  before_filter :authenticate_reseller!, :only => [:specify_tax_id, :update_tax_id]
  before_filter :authenticate_product_manager!, :only => [:index, :show, :edit, :update]
  
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
    redirect_to order_wholesale_orders_path, :notice => "Thanks! Go ahead and place an order. We'll review it before charging you."
  end
end
