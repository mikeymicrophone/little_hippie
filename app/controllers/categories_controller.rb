class CategoriesController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:browse, :show, :detail]
  
  def detail
    @category = Category.find params[:id]
    @product_colors = @category.featured_products
    @large_wide_feature_image = Banner.find_by_name "#{@category.name} Large Wide Feature"
    @large_square_feature_image = Banner.find_by_name "#{@category.name} Large Square Feature"
    render :layout => 'customer'
  end
  
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find_by_slug params[:id]
    @category ||= Category.find_by_id params[:id]
    @product_colors = @category.featured_products
    @large_wide_feature_image = Banner.find_by_name "#{@category.name} Large Wide Feature"
    @large_square_feature_image = Banner.find_by_name "#{@category.name} Large Square Feature"

    respond_to do |format|
      format.html { render action: :detail, layout: 'customer' }
      format.json { render json: @category }
    end
  end
  
  def admin
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html { render action: :show }
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_category_path(@category), notice: 'Category has been created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
