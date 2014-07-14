class ResellersController < ApplicationController
  before_filter :authenticate_reseller!, :only => [:edit, :update]
  before_filter :authenticate_product_manager!, :only => [:index]
  
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
end
