class ProductColorsController < ApplicationController
  before_filter :authenticate_product_manager!
  def search
    @product_colors = ProductColor.search params[:query]
    render :action => :index
  end

  # GET /product_colors
  # GET /product_colors.json
  def index
    @product_colors = if params[:product_id]
      Product.find(params[:product_id]).product_colors
    else
      ProductColor
    end.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_colors }
    end
  end

  # GET /product_colors/1
  # GET /product_colors/1.json
  def show
    @product_color = ProductColor.find(params[:id])
    @inventories = @product_color.inventories

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_color }
    end
  end

  # GET /product_colors/new
  # GET /product_colors/new.json
  def new
    @product_color = ProductColor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_color }
    end
  end

  # GET /product_colors/1/edit
  def edit
    @product_color = ProductColor.find(params[:id])
  end

  # POST /product_colors
  # POST /product_colors.json
  def create
    @product_color = ProductColor.new(params[:product_color])

    respond_to do |format|
      if @product_color.save
        format.html { redirect_to @product_color, notice: 'Product color has been created.' }
        format.json { render json: @product_color, status: :created, location: @product_color }
      else
        format.html { render action: "new" }
        format.json { render json: @product_color.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def choose
    @product = Product.find params[:product_id]
    params[:product_colors].keys.each do |color_id|
      @product.product_colors.create :color_id => color_id
    end
    redirect_to @product
  end

  # PUT /product_colors/1
  # PUT /product_colors/1.json
  def update
    @product_color = ProductColor.find(params[:id])

    respond_to do |format|
      if @product_color.update_attributes(params[:product_color])
        format.html { redirect_to @product_color, notice: 'Product color has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_inventory
    params.each do |k, v|
      if k =~ /inventory_(\d+)/
        Inventory.find($1).update_attribute :amount, v
      end
    end
    redirect_to product_colors_path
  end

  # DELETE /product_colors/1
  # DELETE /product_colors/1.json
  def destroy
    @product_color = ProductColor.find(params[:id])
    @product_color.destroy

    respond_to do |format|
      format.html { redirect_to product_colors_url }
      format.json { head :no_content }
    end
  end
end
