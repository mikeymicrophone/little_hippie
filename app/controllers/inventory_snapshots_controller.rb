class InventorySnapshotsController < ApplicationController
  # GET /inventory_snapshots
  # GET /inventory_snapshots.json
  def index
    @inventory_snapshots = InventorySnapshot.order('current_amount desc').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_snapshots }
    end
  end

  # GET /inventory_snapshots/1
  # GET /inventory_snapshots/1.json
  def show
    @inventory_snapshot = InventorySnapshot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_snapshot }
    end
  end

  # GET /inventory_snapshots/new
  # GET /inventory_snapshots/new.json
  def new
    @inventory_snapshot = InventorySnapshot.new params[:inventory_snapshot]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_snapshot }
    end
  end

  # GET /inventory_snapshots/1/edit
  def edit
    @inventory_snapshot = InventorySnapshot.find(params[:id])
  end

  # POST /inventory_snapshots
  # POST /inventory_snapshots.json
  def create
    @inventory_snapshot = InventorySnapshot.new(params[:inventory_snapshot])

    respond_to do |format|
      if @inventory_snapshot.save
        format.html { redirect_to @inventory_snapshot, notice: 'Inventory snapshot was successfully created.' }
        format.json { render json: @inventory_snapshot, status: :created, location: @inventory_snapshot }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_snapshots/1
  # PUT /inventory_snapshots/1.json
  def update
    @inventory_snapshot = InventorySnapshot.find(params[:id])

    respond_to do |format|
      if @inventory_snapshot.update_attributes(params[:inventory_snapshot])
        format.html { redirect_to @inventory_snapshot, notice: 'Inventory snapshot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_snapshots/1
  # DELETE /inventory_snapshots/1.json
  def destroy
    @inventory_snapshot = InventorySnapshot.find(params[:id])
    @inventory_snapshot.destroy

    respond_to do |format|
      format.html { redirect_to inventory_snapshots_url }
      format.json { head :no_content }
    end
  end
end
