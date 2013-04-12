class BillingAddressesController < ApplicationController
  # GET /billing_addresses
  # GET /billing_addresses.json
  def index
    @billing_addresses = BillingAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @billing_addresses }
    end
  end

  # GET /billing_addresses/1
  # GET /billing_addresses/1.json
  def show
    @billing_address = BillingAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @billing_address }
    end
  end

  # GET /billing_addresses/new
  # GET /billing_addresses/new.json
  def new
    @billing_address = BillingAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @billing_address }
    end
  end

  # GET /billing_addresses/1/edit
  def edit
    @billing_address = BillingAddress.find(params[:id])
  end

  # POST /billing_addresses
  # POST /billing_addresses.json
  def create
    @billing_address = BillingAddress.new(params[:billing_address])

    respond_to do |format|
      if @billing_address.save
        format.html { redirect_to @billing_address, notice: 'Billing address was successfully created.' }
        format.json { render json: @billing_address, status: :created, location: @billing_address }
      else
        format.html { render action: "new" }
        format.json { render json: @billing_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /billing_addresses/1
  # PUT /billing_addresses/1.json
  def update
    @billing_address = BillingAddress.find(params[:id])

    respond_to do |format|
      if @billing_address.update_attributes(params[:billing_address])
        format.html { redirect_to @billing_address, notice: 'Billing address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @billing_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /billing_addresses/1
  # DELETE /billing_addresses/1.json
  def destroy
    @billing_address = BillingAddress.find(params[:id])
    @billing_address.destroy

    respond_to do |format|
      format.html { redirect_to billing_addresses_url }
      format.json { head :no_content }
    end
  end
end
