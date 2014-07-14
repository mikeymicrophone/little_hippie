class WholesaleItemsController < ApplicationController
  # GET /wholesale_items
  # GET /wholesale_items.json
  def index
    @wholesale_items = WholesaleItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wholesale_items }
    end
  end

  # GET /wholesale_items/1
  # GET /wholesale_items/1.json
  def show
    @wholesale_item = WholesaleItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wholesale_item }
    end
  end

  # GET /wholesale_items/new
  # GET /wholesale_items/new.json
  def new
    @wholesale_item = WholesaleItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wholesale_item }
    end
  end

  # GET /wholesale_items/1/edit
  def edit
    @wholesale_item = WholesaleItem.find(params[:id])
  end

  # POST /wholesale_items
  # POST /wholesale_items.json
  def create
    params.each do |key, value|
      if key =~ /quantity_of_garment_(\d+)/
        garment_id = $1
        @wholesale_item = WholesaleItem.new :quantity => value, :garment_id => garment_id
        @wholesale_item.wholesale_order_id = current_wholesale_order.id
        @wholesale_item.save
      end
    end

    respond_to do |format|
      if @wholesale_item.save
        format.html { redirect_to @wholesale_item, notice: 'Wholesale item was successfully created.' }
        format.json { render json: @wholesale_item, status: :created, location: @wholesale_item }
      else
        format.html { render action: "new" }
        format.json { render json: @wholesale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wholesale_items/1
  # PUT /wholesale_items/1.json
  def update
    @wholesale_item = WholesaleItem.find(params[:id])

    respond_to do |format|
      if @wholesale_item.update_attributes(params[:wholesale_item])
        format.js
        format.html { redirect_to @wholesale_item, notice: 'Wholesale item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wholesale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wholesale_items/1
  # DELETE /wholesale_items/1.json
  def destroy
    @wholesale_item = WholesaleItem.find(params[:id])
    @wholesale_item.destroy

    respond_to do |format|
      format.html { redirect_to wholesale_items_url }
      format.json { head :no_content }
    end
  end
end
