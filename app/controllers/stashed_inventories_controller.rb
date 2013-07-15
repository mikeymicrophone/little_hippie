class StashedInventoriesController < ApplicationController
  # GET /stashed_inventories
  # GET /stashed_inventories.json
  def index
    @stashed_inventories = StashedInventory.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stashed_inventories }
    end
  end

  # GET /stashed_inventories/1
  # GET /stashed_inventories/1.json
  def show
    @stashed_inventory = StashedInventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stashed_inventory }
    end
  end

  # GET /stashed_inventories/new
  # GET /stashed_inventories/new.json
  def new
    @stashed_inventory = StashedInventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stashed_inventory }
    end
  end

  # GET /stashed_inventories/1/edit
  def edit
    @stashed_inventory = StashedInventory.find(params[:id])
  end

  # POST /stashed_inventories
  # POST /stashed_inventories.json
  def create
    @stashed_inventory = StashedInventory.new(params[:stashed_inventory])

    respond_to do |format|
      if @stashed_inventory.save
        format.html { redirect_to @stashed_inventory, notice: 'Stashed inventory was successfully created.' }
        format.json { render json: @stashed_inventory, status: :created, location: @stashed_inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @stashed_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stashed_inventories/1
  # PUT /stashed_inventories/1.json
  def update
    @stashed_inventory = StashedInventory.find(params[:id])

    respond_to do |format|
      if @stashed_inventory.update_attributes(params[:stashed_inventory])
        format.html { redirect_to @stashed_inventory, notice: 'Stashed inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stashed_inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stashed_inventories/1
  # DELETE /stashed_inventories/1.json
  def destroy
    @stashed_inventory = StashedInventory.find(params[:id])
    @stashed_inventory.destroy

    respond_to do |format|
      format.html { redirect_to stashed_inventories_url }
      format.json { head :no_content }
    end
  end
end
