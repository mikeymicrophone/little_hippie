class DeliveryAddressesController < ApplicationController
  # GET /delivery_addresses
  # GET /delivery_addresses.json
  def index
    @delivery_addresses = DeliveryAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @delivery_addresses }
    end
  end

  # GET /delivery_addresses/1
  # GET /delivery_addresses/1.json
  def show
    @delivery_address = DeliveryAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @delivery_address }
    end
  end

  # GET /delivery_addresses/new
  # GET /delivery_addresses/new.json
  def new
    @delivery_address = DeliveryAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @delivery_address }
    end
  end

  # GET /delivery_addresses/1/edit
  def edit
    @delivery_address = DeliveryAddress.find(params[:id])
  end

  # POST /delivery_addresses
  # POST /delivery_addresses.json
  def create
    @delivery_address = DeliveryAddress.new(params[:delivery_address])

    respond_to do |format|
      if @delivery_address.save
        format.html { redirect_to @delivery_address, notice: 'Delivery address was successfully created.' }
        format.json { render json: @delivery_address, status: :created, location: @delivery_address }
      else
        format.html { render action: "new" }
        format.json { render json: @delivery_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /delivery_addresses/1
  # PUT /delivery_addresses/1.json
  def update
    @delivery_address = DeliveryAddress.find(params[:id])

    respond_to do |format|
      if @delivery_address.update_attributes(params[:delivery_address])
        format.html { redirect_to @delivery_address, notice: 'Delivery address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_addresses/1
  # DELETE /delivery_addresses/1.json
  def destroy
    @delivery_address = DeliveryAddress.find(params[:id])
    @delivery_address.destroy

    respond_to do |format|
      format.html { redirect_to delivery_addresses_url }
      format.json { head :no_content }
    end
  end
end
