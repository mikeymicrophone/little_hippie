class GarmentsController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /garments
  # GET /garments.json
  def index
    if params[:product_id]
      @garments = Product.find(params[:product_id]).garments.page params[:page]
    elsif params[:size_id]
      @garments = Size.find(params[:size_id]).garments.inventory_order.page params[:page]
    elsif params[:design_id]
      @garments = Design.find(params[:design_id]).garments.inventory_order.page params[:page]
    elsif params[:color_id]
      @garments = Color.find(params[:color_id]).garments.inventory_order.page params[:page]
    else
      @garments = Garment.inventory_order.page params[:page]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @garments }
    end
  end

  # GET /garments/1
  # GET /garments/1.json
  def show
    @garment = Garment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @garment }
    end
  end

  # GET /garments/new
  # GET /garments/new.json
  def new
    @garment = Garment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @garment }
    end
  end

  # GET /garments/1/edit
  def edit
    @garment = Garment.find(params[:id])
  end

  # POST /garments
  # POST /garments.json
  def create
    @garment = Garment.new(params[:garment])

    respond_to do |format|
      if @garment.save
        format.html { redirect_to @garment, notice: 'Garment was successfully created.' }
        format.json { render json: @garment, status: :created, location: @garment }
      else
        format.html { render action: "new" }
        format.json { render json: @garment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /garments/1
  # PUT /garments/1.json
  def update
    @garment = Garment.find(params[:id])

    respond_to do |format|
      if @garment.update_attributes(params[:garment])
        format.html { redirect_to @garment, notice: 'Garment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @garment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garments/1
  # DELETE /garments/1.json
  def destroy
    @garment = Garment.find(params[:id])
    @garment.destroy

    respond_to do |format|
      format.html { redirect_to garments_url }
      format.json { head :no_content }
    end
  end
end
