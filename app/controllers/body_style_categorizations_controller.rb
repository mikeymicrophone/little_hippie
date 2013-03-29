class BodyStyleCategorizationsController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /body_style_categorizations
  # GET /body_style_categorizations.json
  def index
    @body_style_categorizations = if params[:category_id]
      Category.find(params[:category_id]).body_style_categorizations
    else
      BodyStyleCategorization.order(:category_id, :position)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @body_style_categorizations }
    end
  end

  # GET /body_style_categorizations/1
  # GET /body_style_categorizations/1.json
  def show
    @body_style_categorization = BodyStyleCategorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @body_style_categorization }
    end
  end

  # GET /body_style_categorizations/new
  # GET /body_style_categorizations/new.json
  def new
    @body_style_categorization = BodyStyleCategorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @body_style_categorization }
    end
  end

  # GET /body_style_categorizations/1/edit
  def edit
    @body_style_categorization = BodyStyleCategorization.find(params[:id])
  end

  # POST /body_style_categorizations
  # POST /body_style_categorizations.json
  def create
    @body_style_categorization = BodyStyleCategorization.new(params[:body_style_categorization])

    respond_to do |format|
      if @body_style_categorization.save
        format.html { redirect_to @body_style_categorization, notice: 'Body style categorization has been created.' }
        format.json { render json: @body_style_categorization, status: :created, location: @body_style_categorization }
      else
        format.html { render action: "new" }
        format.json { render json: @body_style_categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /body_style_categorizations/1
  # PUT /body_style_categorizations/1.json
  def update
    @body_style_categorization = BodyStyleCategorization.find(params[:id])

    respond_to do |format|
      if @body_style_categorization.update_attributes(params[:body_style_categorization])
        format.html { redirect_to @body_style_categorization, notice: 'Body style categorization has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @body_style_categorization.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @body_style_categorization = BodyStyleCategorization.find params[:id]
    @body_style_categorization.move_higher
    redirect_to :action => :index
  end

  def move_down
    @body_style_categorization = BodyStyleCategorization.find params[:id]
    @body_style_categorization.move_lower
    redirect_to :action => :index
  end

  # DELETE /body_style_categorizations/1
  # DELETE /body_style_categorizations/1.json
  def destroy
    @body_style_categorization = BodyStyleCategorization.find(params[:id])
    @body_style_categorization.destroy

    respond_to do |format|
      format.html { redirect_to body_style_categorizations_url }
      format.json { head :no_content }
    end
  end
end
