class CategoryProductFeaturesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /category_product_features
  # GET /category_product_features.json
  def index
    @category_product_features = if params[:category_id]
      Category.find(params[:category_id]).category_product_features
    else
      CategoryProductFeature.by_category
    end.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_product_features }
    end
  end

  # GET /category_product_features/1
  # GET /category_product_features/1.json
  def show
    @category_product_feature = CategoryProductFeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_product_feature }
    end
  end

  # GET /category_product_features/new
  # GET /category_product_features/new.json
  def new
    @category_product_feature = CategoryProductFeature.new params[:category_product_feature]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_product_feature }
    end
  end

  # GET /category_product_features/1/edit
  def edit
    @category_product_feature = CategoryProductFeature.find(params[:id])
  end

  # POST /category_product_features
  # POST /category_product_features.json
  def create
    @category_product_feature = CategoryProductFeature.new(params[:category_product_feature])

    respond_to do |format|
      if @category_product_feature.save
        format.html { redirect_to @category_product_feature, notice: 'Category product feature was successfully created.' }
        format.json { render json: @category_product_feature, status: :created, location: @category_product_feature }
      else
        format.html { render action: "new" }
        format.json { render json: @category_product_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_product_features/1
  # PUT /category_product_features/1.json
  def update
    @category_product_feature = CategoryProductFeature.find(params[:id])
    
    if params[:commit] == 'Move'
      @category_product_feature.insert_at params[:category_product_feature][:position].to_i
    end

    respond_to do |format|
      if @category_product_feature.update_attributes(params[:category_product_feature])
        format.js
        format.html { redirect_to @category_product_feature, notice: 'Category product feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_product_feature.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @category_product_feature = CategoryProductFeature.find params[:id]
    @category_product_feature.move_higher
    redirect_to :action => :index
  end
  
  def move_down
    @category_product_feature = CategoryProductFeature.find params[:id]
    @category_product_feature.move_lower
    redirect_to :action => :index    
  end

  # DELETE /category_product_features/1
  # DELETE /category_product_features/1.json
  def destroy
    @category_product_feature = CategoryProductFeature.find(params[:id])
    @category_product_feature.destroy

    respond_to do |format|
      format.html { redirect_to category_product_features_url }
      format.json { head :no_content }
    end
  end
end
