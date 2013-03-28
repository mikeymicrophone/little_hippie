class ImagePositionTemplatesController < ApplicationController
  before_filter :authenticate_product_manager!
  
  def load
    @image_position_template = ImagePositionTemplate.find params[:id]
    
    respond_to do |format|
      format.js
    end
  end
  
  # GET /image_position_templates
  # GET /image_position_templates.json
  def index
    @image_position_templates = ImagePositionTemplate.ordered

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @image_position_templates }
    end
  end

  # GET /image_position_templates/1
  # GET /image_position_templates/1.json
  def show
    @image_position_template = ImagePositionTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image_position_template }
    end
  end

  # GET /image_position_templates/new
  # GET /image_position_templates/new.json
  def new
    @image_position_template = ImagePositionTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image_position_template }
    end
  end

  # GET /image_position_templates/1/edit
  def edit
    @image_position_template = ImagePositionTemplate.find(params[:id])
  end

  # POST /image_position_templates
  # POST /image_position_templates.json
  def create
    @image_position_template = ImagePositionTemplate.new(params[:image_position_template])

    respond_to do |format|
      if @image_position_template.save
        format.html { redirect_to @image_position_template, notice: 'Image position template was successfully created.' }
        format.json { render json: @image_position_template, status: :created, location: @image_position_template }
      else
        format.html { render action: "new" }
        format.json { render json: @image_position_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /image_position_templates/1
  # PUT /image_position_templates/1.json
  def update
    @image_position_template = ImagePositionTemplate.find(params[:id])

    respond_to do |format|
      if @image_position_template.update_attributes(params[:image_position_template])
        format.html { redirect_to @image_position_template, notice: 'Image position template was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image_position_template.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @image_position_template = ImagePositionTemplate.find params[:id]
    @image_position_template.move_higher
    redirect_to :action => :index
  end
  
  def move_down
    @image_position_template = ImagePositionTemplate.find params[:id]
    @image_position_template.move_lower
    redirect_to :action => :index    
  end

  # DELETE /image_position_templates/1
  # DELETE /image_position_templates/1.json
  def destroy
    @image_position_template = ImagePositionTemplate.find(params[:id])
    @image_position_template.destroy

    respond_to do |format|
      format.html { redirect_to image_position_templates_url }
      format.json { head :no_content }
    end
  end
end
