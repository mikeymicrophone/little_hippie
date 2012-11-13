class BodyStylesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /body_styles
  # GET /body_styles.json
  def index
    @body_styles = BodyStyle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @body_styles }
    end
  end

  # GET /body_styles/1
  # GET /body_styles/1.json
  def show
    @body_style = BodyStyle.find(params[:id])
    @products = @body_style.products

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @body_style }
    end
  end

  # GET /body_styles/new
  # GET /body_styles/new.json
  def new
    @body_style = BodyStyle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @body_style }
    end
  end

  # GET /body_styles/1/edit
  def edit
    @body_style = BodyStyle.find(params[:id])
  end

  # POST /body_styles
  # POST /body_styles.json
  def create
    @body_style = BodyStyle.new(params[:body_style])

    respond_to do |format|
      if @body_style.save
        format.html { redirect_to @body_style, notice: 'Body style was successfully created.' }
        format.json { render json: @body_style, status: :created, location: @body_style }
      else
        format.html { render action: "new" }
        format.json { render json: @body_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /body_styles/1
  # PUT /body_styles/1.json
  def update
    @body_style = BodyStyle.find(params[:id])

    respond_to do |format|
      if @body_style.update_attributes(params[:body_style])
        format.html { redirect_to @body_style, notice: 'Body style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body_style.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @body_style = BodyStyle.find(params[:id])
    @body_style.move_higher
    redirect_to :action => 'index'
  end
  
  # DELETE /body_styles/1
  # DELETE /body_styles/1.json
  def destroy
    @body_style = BodyStyle.find(params[:id])
    @body_style.destroy

    respond_to do |format|
      format.html { redirect_to body_styles_url }
      format.json { head :no_content }
    end
  end
end
