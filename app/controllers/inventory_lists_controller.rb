class InventoryListsController < ApplicationController
  # GET /inventory_lists
  # GET /inventory_lists.json
  def index
    @inventory_lists = InventoryList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_lists }
    end
  end

  # GET /inventory_lists/1
  # GET /inventory_lists/1.json
  def show
    @inventory_list = InventoryList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_list }
    end
  end

  # GET /inventory_lists/new
  # GET /inventory_lists/new.json
  def new
    @inventory_list = InventoryList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_list }
    end
  end

  # GET /inventory_lists/1/edit
  def edit
    @inventory_list = InventoryList.find(params[:id])
  end

  # POST /inventory_lists
  # POST /inventory_lists.json
  def create
    @inventory_list = InventoryList.new(params[:inventory_list])

    respond_to do |format|
      if @inventory_list.save
        Resque.enqueue InventoryUpdate, @inventory_list.id
        format.html { redirect_to @inventory_list, notice: 'Inventory list was successfully created.' }
        format.json { render json: @inventory_list, status: :created, location: @inventory_list }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_lists/1
  # PUT /inventory_lists/1.json
  def update
    @inventory_list = InventoryList.find(params[:id])

    respond_to do |format|
      if @inventory_list.update_attributes(params[:inventory_list])
        format.html { redirect_to @inventory_list, notice: 'Inventory list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_lists/1
  # DELETE /inventory_lists/1.json
  def destroy
    @inventory_list = InventoryList.find(params[:id])
    @inventory_list.destroy

    respond_to do |format|
      format.html { redirect_to inventory_lists_url }
      format.json { head :no_content }
    end
  end
end
