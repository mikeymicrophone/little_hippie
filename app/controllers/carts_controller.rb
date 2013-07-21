class CartsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:index, :show, :update_note]
  before_filter :determine_cart_ownership, :only => :show
  # GET /carts
  # GET /carts.json
  def index
    @carts = if params[:customer_id]
      if current_product_manager
        Customer.find(params[:customer_id]).carts
      elsif current_customer
        current_customer.carts
      end
    elsif current_product_manager
      if params[:referral_id]
        Referral.find(params[:referral_id]).carts
      else
        Cart
      end.order('status', 'created_at desc')
    else
      redirect_to(root_url) && return
    end.page(params[:page])

    respond_to do |format|
      format.html do
        if current_product_manager
          render
        else
          render :action => 'purchase_history', :layout => 'customer'
        end
      end
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if Cart.complete.exists?(@cart)
        format.html { render(:layout => 'customer', :action => 'purchase')}
        format.json { render json: @cart }
      else
        format.html { render(:layout => 'customer', :action => 'checkout') }
        format.json { render json: @cart }
      end
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_note
    @cart = current_cart
    @cart.update_attribute :gift_note, params[:gift_note] if params[:gift_note]
    @cart.update_attribute :shipping_instructions, params[:shipping_instructions] if params[:shipping_instructions]
    render :nothing => true
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end
  
  def determine_cart_ownership
    return true if current_product_manager || current_business_manager
    return true if session[:cart_id] == params[:id].to_i
    return true if (Cart.find(params[:id]).customer == current_customer) && current_customer
    redirect_to root_url
  end
end
