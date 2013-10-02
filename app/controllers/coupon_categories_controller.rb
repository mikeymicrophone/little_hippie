class CouponCategoriesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /coupon_categories
  # GET /coupon_categories.json
  def index
    @coupon_categories = CouponCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupon_categories }
    end
  end

  # GET /coupon_categories/1
  # GET /coupon_categories/1.json
  def show
    @coupon_category = CouponCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon_category }
    end
  end

  # GET /coupon_categories/new
  # GET /coupon_categories/new.json
  def new
    @coupon_category = CouponCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon_category }
    end
  end

  # GET /coupon_categories/1/edit
  def edit
    @coupon_category = CouponCategory.find(params[:id])
  end

  # POST /coupon_categories
  # POST /coupon_categories.json
  def create
    @coupon_category = CouponCategory.new(params[:coupon_category])

    respond_to do |format|
      if @coupon_category.save
        format.html { redirect_to @coupon_category, notice: 'Coupon category was successfully created.' }
        format.json { render json: @coupon_category, status: :created, location: @coupon_category }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupon_categories/1
  # PUT /coupon_categories/1.json
  def update
    @coupon_category = CouponCategory.find(params[:id])

    respond_to do |format|
      if @coupon_category.update_attributes(params[:coupon_category])
        format.html { redirect_to @coupon_category, notice: 'Coupon category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_categories/1
  # DELETE /coupon_categories/1.json
  def destroy
    @coupon_category = CouponCategory.find(params[:id])
    @coupon_category.destroy

    respond_to do |format|
      format.html { redirect_to coupon_categories_url }
      format.json { head :no_content }
    end
  end
end
