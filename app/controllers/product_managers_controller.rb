class ProductManagersController < ApplicationController
  before_filter :authenticate_business_manager!
  # GET /product_managers
  # GET /product_managers.json
  def index
    @product_managers = ProductManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_managers }
    end
  end

  # GET /product_managers/1
  # GET /product_managers/1.json
  def show
    @product_manager = ProductManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_manager }
    end
  end

  # GET /product_managers/new
  # GET /product_managers/new.json
  def new
    @product_manager = ProductManager.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_manager }
    end
  end

  # GET /product_managers/1/edit
  def edit
    @product_manager = ProductManager.find(params[:id])
  end

  # POST /product_managers
  # POST /product_managers.json
  def create
    @product_manager = ProductManager.new(params[:product_manager])

    respond_to do |format|
      if @product_manager.save
        format.html { redirect_to @product_manager, notice: 'Product manager has been created.' }
        format.json { render json: @product_manager, status: :created, location: @product_manager }
      else
        format.html { render action: "new" }
        format.json { render json: @product_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_managers/1
  # PUT /product_managers/1.json
  def update
    @product_manager = ProductManager.find(params[:id])

    respond_to do |format|
      if @product_manager.update_attributes(params[:product_manager])
        format.html { redirect_to @product_manager, notice: 'Product manager has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_managers/1
  # DELETE /product_managers/1.json
  def destroy
    @product_manager = ProductManager.find(params[:id])
    @product_manager.destroy

    respond_to do |format|
      format.html { redirect_to product_managers_url }
      format.json { head :no_content }
    end
  end
end
