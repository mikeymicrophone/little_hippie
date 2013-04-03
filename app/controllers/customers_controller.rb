class CustomersController < ApplicationController
  before_filter :authenticate_business_manager!, :except => :show
  # GET /customers
  # GET /customers.json
  def index
    @customers = if params[:sort] == 'email'
      Customer.order(:email)
    else
      Customer
    end.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  def detail
    @customer = Customer.find(params[:id])
    redirect_to(root_url) && return unless @customer == current_customer
    @suggested_products = Product.all(:limit => 55).sample(8)
    respond_to do |format|
      format.html { render action: :detail, layout: 'customer' }
    end    
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    detail
  end
  
  def admin_show
    @customer = Customer.find params[:id]
    
    respond_to do |format|
      format.html { render action: :show }
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        current_cart @customer
        format.js
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end
