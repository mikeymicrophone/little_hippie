class GarmentPurchaseOrdersController < ApplicationController
  # GET /garment_purchase_orders
  # GET /garment_purchase_orders.json
  def index
    @garment_purchase_orders = GarmentPurchaseOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @garment_purchase_orders }
    end
  end

  # GET /garment_purchase_orders/1
  # GET /garment_purchase_orders/1.json
  def show
    @garment_purchase_order = GarmentPurchaseOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @garment_purchase_order }
    end
  end

  # GET /garment_purchase_orders/new
  # GET /garment_purchase_orders/new.json
  def new
    @garment_purchase_order = GarmentPurchaseOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @garment_purchase_order }
    end
  end

  # GET /garment_purchase_orders/1/edit
  def edit
    @garment_purchase_order = GarmentPurchaseOrder.find(params[:id])
  end

  # POST /garment_purchase_orders
  # POST /garment_purchase_orders.json
  def create
    @garment_purchase_order = GarmentPurchaseOrder.new(params[:garment_purchase_order])

    respond_to do |format|
      if @garment_purchase_order.save
        format.html { redirect_to @garment_purchase_order, notice: 'Garment purchase order was successfully created.' }
        format.json { render json: @garment_purchase_order, status: :created, location: @garment_purchase_order }
      else
        format.html { render action: "new" }
        format.json { render json: @garment_purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /garment_purchase_orders/1
  # PUT /garment_purchase_orders/1.json
  def update
    @garment_purchase_order = GarmentPurchaseOrder.find(params[:id])

    respond_to do |format|
      if @garment_purchase_order.update_attributes(params[:garment_purchase_order])
        format.html { redirect_to @garment_purchase_order, notice: 'Garment purchase order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @garment_purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garment_purchase_orders/1
  # DELETE /garment_purchase_orders/1.json
  def destroy
    @garment_purchase_order = GarmentPurchaseOrder.find(params[:id])
    @garment_purchase_order.destroy

    respond_to do |format|
      format.html { redirect_to garment_purchase_orders_url }
      format.json { head :no_content }
    end
  end
end
