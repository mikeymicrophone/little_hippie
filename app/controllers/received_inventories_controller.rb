class ReceivedInventoriesController < ApplicationController
  # GET /received_inventories
  # GET /received_inventories.json
  def index
    @received_inventories = ReceivedInventory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @received_inventories }
    end
  end

  # GET /received_inventories/1
  # GET /received_inventories/1.json
  def show
    @received_inventory = ReceivedInventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @received_inventory }
    end
  end

  # GET /received_inventories/new
  # GET /received_inventories/new.json
  def new
    @received_inventory = ReceivedInventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @received_inventory }
    end
  end

  # GET /received_inventories/1/edit
  def edit
    @received_inventory = ReceivedInventory.find(params[:id])
  end

  # POST /received_inventories
  # POST /received_inventories.json
  def create
    @received_inventory = ReceivedInventory.new(params[:received_inventory])

    respond_to do |format|
      if @received_inventory.save
        format.html { redirect_to @received_inventory, notice: 'Received inventory was successfully created.' }
        format.json { render json: @received_inventory, status: :created, location: @received_inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @received_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /received_inventories/1
  # PUT /received_inventories/1.json
  def update
    @received_inventory = ReceivedInventory.find(params[:id])

    respond_to do |format|
      if @received_inventory.update_attributes(params[:received_inventory])
        format.html { redirect_to @received_inventory, notice: 'Received inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @received_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /received_inventories/1
  # DELETE /received_inventories/1.json
  def destroy
    @received_inventory = ReceivedInventory.find(params[:id])
    @received_inventory.destroy

    respond_to do |format|
      format.html { redirect_to received_inventories_url }
      format.json { head :no_content }
    end
  end
end
