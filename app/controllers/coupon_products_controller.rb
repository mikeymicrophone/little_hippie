class CouponProductsController < ApplicationController
  # GET /coupon_products
  # GET /coupon_products.json
  def index
    @coupon_products = CouponProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupon_products }
    end
  end

  # GET /coupon_products/1
  # GET /coupon_products/1.json
  def show
    @coupon_product = CouponProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon_product }
    end
  end

  # GET /coupon_products/new
  # GET /coupon_products/new.json
  def new
    @coupon_product = CouponProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon_product }
    end
  end

  # GET /coupon_products/1/edit
  def edit
    @coupon_product = CouponProduct.find(params[:id])
  end

  # POST /coupon_products
  # POST /coupon_products.json
  def create
    @coupon_product = CouponProduct.new(params[:coupon_product])

    respond_to do |format|
      if @coupon_product.save
        format.html { redirect_to @coupon_product, notice: 'Coupon product was successfully created.' }
        format.json { render json: @coupon_product, status: :created, location: @coupon_product }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupon_products/1
  # PUT /coupon_products/1.json
  def update
    @coupon_product = CouponProduct.find(params[:id])

    respond_to do |format|
      if @coupon_product.update_attributes(params[:coupon_product])
        format.html { redirect_to @coupon_product, notice: 'Coupon product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_products/1
  # DELETE /coupon_products/1.json
  def destroy
    @coupon_product = CouponProduct.find(params[:id])
    @coupon_product.destroy

    respond_to do |format|
      format.html { redirect_to coupon_products_url }
      format.json { head :no_content }
    end
  end
end
