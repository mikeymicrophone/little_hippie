class WholesaleOrdersController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:order, :body_style]
  before_filter :authenticate_reseller!, :only => [:order, :body_style]
  
  def order
    @categories = Category.age_group
    render :layout => 'customer'
  end
  
  def body_style
    @body_style = BodyStyle.find params[:body_style_id]
    @products = @body_style.products
  end
  
  # GET /wholesale_orders
  # GET /wholesale_orders.json
  def index
    @wholesale_orders = WholesaleOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wholesale_orders }
    end
  end

  # GET /wholesale_orders/1
  # GET /wholesale_orders/1.json
  def show
    @wholesale_order = WholesaleOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wholesale_order }
    end
  end

  # GET /wholesale_orders/new
  # GET /wholesale_orders/new.json
  def new
    @wholesale_order = WholesaleOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wholesale_order }
    end
  end

  # GET /wholesale_orders/1/edit
  def edit
    @wholesale_order = WholesaleOrder.find(params[:id])
  end

  # POST /wholesale_orders
  # POST /wholesale_orders.json
  def create
    @wholesale_order = WholesaleOrder.new(params[:wholesale_order])

    respond_to do |format|
      if @wholesale_order.save
        format.html { redirect_to @wholesale_order, notice: 'Wholesale order was successfully created.' }
        format.json { render json: @wholesale_order, status: :created, location: @wholesale_order }
      else
        format.html { render action: "new" }
        format.json { render json: @wholesale_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wholesale_orders/1
  # PUT /wholesale_orders/1.json
  def update
    @wholesale_order = WholesaleOrder.find(params[:id])

    respond_to do |format|
      if @wholesale_order.update_attributes(params[:wholesale_order])
        format.html { redirect_to @wholesale_order, notice: 'Wholesale order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wholesale_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wholesale_orders/1
  # DELETE /wholesale_orders/1.json
  def destroy
    @wholesale_order = WholesaleOrder.find(params[:id])
    @wholesale_order.destroy

    respond_to do |format|
      format.html { redirect_to wholesale_orders_url }
      format.json { head :no_content }
    end
  end
end
