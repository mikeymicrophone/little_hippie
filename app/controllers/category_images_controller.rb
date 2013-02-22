class CategoryImagesController < ApplicationController
  # GET /category_images
  # GET /category_images.json
  def index
    @category_images = CategoryImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_images }
    end
  end

  # GET /category_images/1
  # GET /category_images/1.json
  def show
    @category_image = CategoryImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_image }
    end
  end

  # GET /category_images/new
  # GET /category_images/new.json
  def new
    @category_image = CategoryImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_image }
    end
  end

  # GET /category_images/1/edit
  def edit
    @category_image = CategoryImage.find(params[:id])
  end

  # POST /category_images
  # POST /category_images.json
  def create
    @category_image = CategoryImage.new(params[:category_image])

    respond_to do |format|
      if @category_image.save
        format.html { redirect_to @category_image, notice: 'Category image was successfully created.' }
        format.json { render json: @category_image, status: :created, location: @category_image }
      else
        format.html { render action: "new" }
        format.json { render json: @category_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_images/1
  # PUT /category_images/1.json
  def update
    @category_image = CategoryImage.find(params[:id])

    respond_to do |format|
      if @category_image.update_attributes(params[:category_image])
        format.html { redirect_to @category_image, notice: 'Category image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_images/1
  # DELETE /category_images/1.json
  def destroy
    @category_image = CategoryImage.find(params[:id])
    @category_image.destroy

    respond_to do |format|
      format.html { redirect_to category_images_url }
      format.json { head :no_content }
    end
  end
end
