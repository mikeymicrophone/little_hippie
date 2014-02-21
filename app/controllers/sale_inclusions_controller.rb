class SaleInclusionsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:check_products, :check_product_colors]
  
  def list
    if params[:group] == 'Year'
      Struct.new('Year', :id, :name)
      @list = (2003..Time.now.year).to_a.map { |i| Struct::Year.new i, i }
    else
      @list = params[:group].constantize.send(:all)
    end
  end
  
  def check_products
    (render(:nothing => true) && return) unless params[:product_ids].present?
    @products = Product.find params[:product_ids]
    @sale_products = @products.select { |p| p.is_on_sale? }
    @sale_product_colors = @sale_products.map(&:product_colors).flatten
  end
  
  def check_product_colors
    (render(:nothing => true) && return) unless params[:product_color_ids].present?
    @product_colors = ProductColor.find params[:product_color_ids]
    @sale_product_colors = @product_colors.select { |p| p.is_on_sale? }
    render :action => 'check_products'
  end

  # GET /sale_inclusions
  # GET /sale_inclusions.json
  def index
    @sale_inclusions = SaleInclusion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sale_inclusions }
    end
  end

  # GET /sale_inclusions/1
  # GET /sale_inclusions/1.json
  def show
    @sale_inclusion = SaleInclusion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale_inclusion }
    end
  end

  # GET /sale_inclusions/new
  # GET /sale_inclusions/new.json
  def new
    @sale_inclusion = SaleInclusion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale_inclusion }
    end
  end

  # GET /sale_inclusions/1/edit
  def edit
    @sale_inclusion = SaleInclusion.find(params[:id])
  end

  # POST /sale_inclusions
  # POST /sale_inclusions.json
  def create
    @sale_inclusion = SaleInclusion.new(params[:sale_inclusion])

    respond_to do |format|
      if @sale_inclusion.save
        format.html { redirect_to @sale_inclusion, notice: 'Sale inclusion was successfully created.' }
        format.json { render json: @sale_inclusion, status: :created, location: @sale_inclusion }
      else
        format.html { render action: "new" }
        format.json { render json: @sale_inclusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sale_inclusions/1
  # PUT /sale_inclusions/1.json
  def update
    @sale_inclusion = SaleInclusion.find(params[:id])

    respond_to do |format|
      if @sale_inclusion.update_attributes(params[:sale_inclusion])
        format.html { redirect_to @sale_inclusion, notice: 'Sale inclusion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sale_inclusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sale_inclusions/1
  # DELETE /sale_inclusions/1.json
  def destroy
    @sale_inclusion = SaleInclusion.find(params[:id])
    @sale_inclusion.destroy

    respond_to do |format|
      format.html { redirect_to sale_inclusions_url }
      format.json { head :no_content }
    end
  end
end
