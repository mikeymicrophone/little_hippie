class BodyStyleProductFeaturesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /body_style_product_features
  # GET /body_style_product_features.json
  def index
    @body_style_product_features = BodyStyleProductFeature.by_body_style

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @body_style_product_features }
    end
  end

  # GET /body_style_product_features/1
  # GET /body_style_product_features/1.json
  def show
    @body_style_product_feature = BodyStyleProductFeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @body_style_product_feature }
    end
  end

  # GET /body_style_product_features/new
  # GET /body_style_product_features/new.json
  def new
    @body_style_product_feature = BodyStyleProductFeature.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @body_style_product_feature }
    end
  end

  # GET /body_style_product_features/1/edit
  def edit
    @body_style_product_feature = BodyStyleProductFeature.find(params[:id])
  end

  # POST /body_style_product_features
  # POST /body_style_product_features.json
  def create
    @body_style_product_feature = BodyStyleProductFeature.new(params[:body_style_product_feature])

    respond_to do |format|
      if @body_style_product_feature.save
        format.html { redirect_to @body_style_product_feature, notice: 'Body style product feature was successfully created.' }
        format.json { render json: @body_style_product_feature, status: :created, location: @body_style_product_feature }
      else
        format.html { render action: "new" }
        format.json { render json: @body_style_product_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /body_style_product_features/1
  # PUT /body_style_product_features/1.json
  def update
    @body_style_product_feature = BodyStyleProductFeature.find(params[:id])

    respond_to do |format|
      if @body_style_product_feature.update_attributes(params[:body_style_product_feature])
        format.html { redirect_to @body_style_product_feature, notice: 'Body style product feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body_style_product_feature.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @body_style_product_feature = BodyStyleProductFeature.find params[:id]
    @body_style_product_feature.move_higher
    redirect_to :action => :index
  end
  
  def move_down
    @body_style_product_feature = BodyStyleProductFeature.find params[:id]
    @body_style_product_feature.move_lower
    redirect_to :action => :index
  end

  # DELETE /body_style_product_features/1
  # DELETE /body_style_product_features/1.json
  def destroy
    @body_style_product_feature = BodyStyleProductFeature.find(params[:id])
    @body_style_product_feature.destroy

    respond_to do |format|
      format.html { redirect_to body_style_product_features_url }
      format.json { head :no_content }
    end
  end
end
