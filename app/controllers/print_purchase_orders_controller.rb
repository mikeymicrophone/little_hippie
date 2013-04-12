class PrintPurchaseOrdersController < ApplicationController
  # GET /print_purchase_orders
  # GET /print_purchase_orders.json
  def index
    @print_purchase_orders = PrintPurchaseOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @print_purchase_orders }
    end
  end

  # GET /print_purchase_orders/1
  # GET /print_purchase_orders/1.json
  def show
    @print_purchase_order = PrintPurchaseOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @print_purchase_order }
    end
  end

  # GET /print_purchase_orders/new
  # GET /print_purchase_orders/new.json
  def new
    @print_purchase_order = PrintPurchaseOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @print_purchase_order }
    end
  end

  # GET /print_purchase_orders/1/edit
  def edit
    @print_purchase_order = PrintPurchaseOrder.find(params[:id])
  end

  # POST /print_purchase_orders
  # POST /print_purchase_orders.json
  def create
    @print_purchase_order = PrintPurchaseOrder.new(params[:print_purchase_order])

    respond_to do |format|
      if @print_purchase_order.save
        format.html { redirect_to @print_purchase_order, notice: 'Print purchase order was successfully created.' }
        format.json { render json: @print_purchase_order, status: :created, location: @print_purchase_order }
      else
        format.html { render action: "new" }
        format.json { render json: @print_purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /print_purchase_orders/1
  # PUT /print_purchase_orders/1.json
  def update
    @print_purchase_order = PrintPurchaseOrder.find(params[:id])

    respond_to do |format|
      if @print_purchase_order.update_attributes(params[:print_purchase_order])
        format.html { redirect_to @print_purchase_order, notice: 'Print purchase order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @print_purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /print_purchase_orders/1
  # DELETE /print_purchase_orders/1.json
  def destroy
    @print_purchase_order = PrintPurchaseOrder.find(params[:id])
    @print_purchase_order.destroy

    respond_to do |format|
      format.html { redirect_to print_purchase_orders_url }
      format.json { head :no_content }
    end
  end
end
