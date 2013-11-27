class CouponDesignsController < ApplicationController
  # GET /coupon_designs
  # GET /coupon_designs.json
  def index
    @coupon_designs = CouponDesign.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupon_designs }
    end
  end

  # GET /coupon_designs/1
  # GET /coupon_designs/1.json
  def show
    @coupon_design = CouponDesign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon_design }
    end
  end

  # GET /coupon_designs/new
  # GET /coupon_designs/new.json
  def new
    @coupon_design = CouponDesign.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon_design }
    end
  end

  # GET /coupon_designs/1/edit
  def edit
    @coupon_design = CouponDesign.find(params[:id])
  end

  # POST /coupon_designs
  # POST /coupon_designs.json
  def create
    @coupon_design = CouponDesign.new(params[:coupon_design])

    respond_to do |format|
      if @coupon_design.save
        format.html { redirect_to @coupon_design, notice: 'Coupon design was successfully created.' }
        format.json { render json: @coupon_design, status: :created, location: @coupon_design }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon_design.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupon_designs/1
  # PUT /coupon_designs/1.json
  def update
    @coupon_design = CouponDesign.find(params[:id])

    respond_to do |format|
      if @coupon_design.update_attributes(params[:coupon_design])
        format.html { redirect_to @coupon_design, notice: 'Coupon design was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon_design.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_designs/1
  # DELETE /coupon_designs/1.json
  def destroy
    @coupon_design = CouponDesign.find(params[:id])
    @coupon_design.destroy

    respond_to do |format|
      format.html { redirect_to coupon_designs_url }
      format.json { head :no_content }
    end
  end
end
