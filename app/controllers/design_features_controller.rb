class DesignFeaturesController < ApplicationController
  before_filter :authenticate_business_manager!
  # GET /design_features
  # GET /design_features.json
  def index
    @design_features = DesignFeature.ordered

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @design_features }
    end
  end

  # GET /design_features/1
  # GET /design_features/1.json
  def show
    @design_feature = DesignFeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @design_feature }
    end
  end

  # GET /design_features/new
  # GET /design_features/new.json
  def new
    @design_feature = DesignFeature.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @design_feature }
    end
  end

  # GET /design_features/1/edit
  def edit
    @design_feature = DesignFeature.find(params[:id])
  end

  # POST /design_features
  # POST /design_features.json
  def create
    @design_feature = DesignFeature.new(params[:design_feature])
    @design_feature.business_manager = current_business_manager

    respond_to do |format|
      if @design_feature.save
        format.html { redirect_to @design_feature, notice: 'Design feature was successfully created.' }
        format.json { render json: @design_feature, status: :created, location: @design_feature }
      else
        format.html { render action: "new" }
        format.json { render json: @design_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /design_features/1
  # PUT /design_features/1.json
  def update
    @design_feature = DesignFeature.find(params[:id])

    respond_to do |format|
      if @design_feature.update_attributes(params[:design_feature])
        format.html { redirect_to @design_feature, notice: 'Design feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @design_feature.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @design_feature = DesignFeature.find params[:id]
    @design_feature.move_higher
    redirect_to :action => :index
  end
  
  def move_down
    @design_feature = DesignFeature.find params[:id]
    @design_feature.move_lower
    redirect_to :action => :index
  end

  # DELETE /design_features/1
  # DELETE /design_features/1.json
  def destroy
    @design_feature = DesignFeature.find(params[:id])
    @design_feature.destroy

    respond_to do |format|
      format.html { redirect_to design_features_url }
      format.json { head :no_content }
    end
  end
end
