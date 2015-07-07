class InventoriesController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:browse, :detail, :update_current_inventory, :inventory_report]
  
  def browse
    @page = ContentPage.find_by_slug('home')
    @categories = @page.categories.active[0..6] || []
    @bulletins = @page.bulletins.active.limit(15) || []
    render :layout => 'customer'
  end
  
  def update_old_glory_inventory
    
  end
  
  def deliver_old_glory
    filename = File.join(Rails.root, 'tmp', 'current_inventory.xml')
    File.open(filename, 'wb') { |f| f.write(params[:xml][:file].read) }
    Resque.enqueue InventoryUpdate, filename
  end
  
  def update_current_inventory
    @product_color = ProductColor.find_by_og_code params[:sku]
    params[:inventory].each do |size_code, current_amount|
      body_style = @product_color.body_style
      body_style_size = body_style.body_style_sizes.find_by_size_id(Size.find_by_code size_code)
      stock = body_style_size.stocks.find_by_color_id @product_color.color_id
      garment = stock.garments.find_by_design_id @product_color.design_id
      garment.set_inventory current_amount
    end
  end
  
  def inventory_report
    @inventory_totals = ProductColor.order(:og_code).map do |product_color|
      product_color.body_style_sizes.map do |body_style_size|
        [[:sku, product_color.og_code], [:size, body_style_size.size.code], [:amount, product_color.in_inventory_by_size_id(body_style_size.id)]].to_h
      end
    end.flatten
  end
  
  def detail
    @inventory = Inventory.find params[:id]
  end
  
  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = Inventory.order('amount desc').where('amount > 0').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to @inventory, notice: 'Inventory has been created.' }
        format.json { render json: @inventory, status: :created, location: @inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to @inventory, notice: 'Inventory has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url }
      format.json { head :no_content }
    end
  end
end
