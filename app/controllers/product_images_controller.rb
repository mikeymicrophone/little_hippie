class ProductImagesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /product_images
  # GET /product_images.json
  def index
    @product_images = if params[:image_position_template_id]
      ImagePositionTemplate.find(params[:image_position_template_id]).product_images
    else
      ProductImage.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_images }
    end
  end

  # GET /product_images/1
  # GET /product_images/1.json
  def show
    @product_image = ProductImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_image }
    end
  end

  # GET /product_images/new
  # GET /product_images/new.json
  def new
    @product_image = ProductImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_image }
    end
  end

  # GET /product_images/1/edit
  def edit
    @product_image = ProductImage.find(params[:id])
  end

  # POST /product_images
  # POST /product_images.json
  def create
    @product_image = ProductImage.new(params[:product_image])

    respond_to do |format|
      if @product_image.save
        format.html { redirect_to @product_image, notice: 'Product image has been created.' }
        format.json { render json: @product_image, status: :created, location: @product_image }
      else
        format.html { render action: "new" }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_images/1
  # PUT /product_images/1.json
  def update
    @product_image = ProductImage.find(params[:id])

    respond_to do |format|
      if @product_image.update_attributes(params[:product_image])
        format.html { redirect_to @product_image, notice: 'Product image has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_images/1
  # DELETE /product_images/1.json
  def destroy
    @product_image = ProductImage.find(params[:id])
    @product_image.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to product_images_url }
      format.json { head :no_content }
    end
  end
end
