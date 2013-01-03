class BodyStyleSizesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /body_style_sizes
  # GET /body_style_sizes.json
  def index
    @body_style_sizes = BodyStyleSize.ordered

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @body_style_sizes }
    end
  end

  # GET /body_style_sizes/1
  # GET /body_style_sizes/1.json
  def show
    @body_style_size = BodyStyleSize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @body_style_size }
    end
  end

  # GET /body_style_sizes/new
  # GET /body_style_sizes/new.json
  def new
    @body_style_size = BodyStyleSize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @body_style_size }
    end
  end

  # GET /body_style_sizes/1/edit
  def edit
    @body_style_size = BodyStyleSize.find(params[:id])
  end

  # POST /body_style_sizes
  # POST /body_style_sizes.json
  def create
    @body_style_size = BodyStyleSize.new(params[:body_style_size])

    respond_to do |format|
      if @body_style_size.save
        format.html { redirect_to :action => :index, notice: 'Body style size was successfully created.' }
        format.json { render json: @body_style_size, status: :created, location: @body_style_size }
      else
        format.html { render action: "new" }
        format.json { render json: @body_style_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /body_style_sizes/1
  # PUT /body_style_sizes/1.json
  def update
    @body_style_size = BodyStyleSize.find(params[:id])

    respond_to do |format|
      if @body_style_size.update_attributes(params[:body_style_size])
        format.html { redirect_to @body_style_size, notice: 'Body style size was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body_style_size.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    BodyStyleSize.find(params[:id]).move_higher
    redirect_to body_style_sizes_path
  end
  
  def move_down
    BodyStyleSize.find(params[:id]).move_lower
    redirect_to body_style_sizes_path
  end

  # DELETE /body_style_sizes/1
  # DELETE /body_style_sizes/1.json
  def destroy
    @body_style_size = BodyStyleSize.find(params[:id])
    @body_style_size.destroy

    respond_to do |format|
      format.html { redirect_to body_style_sizes_url }
      format.json { head :no_content }
    end
  end
end
