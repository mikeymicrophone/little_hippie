class UnitPricesController < ApplicationController
  # GET /unit_prices
  # GET /unit_prices.json
  def index
    @unit_prices = UnitPrice.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unit_prices }
    end
  end

  # GET /unit_prices/1
  # GET /unit_prices/1.json
  def show
    @unit_price = UnitPrice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit_price }
    end
  end

  # GET /unit_prices/new
  # GET /unit_prices/new.json
  def new
    params[:unit_price] ||= {}
    params[:unit_price][:body_style_size_id] = params[:body_style_size_id]
    @unit_price = UnitPrice.new params[:unit_price]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unit_price }
    end
  end

  # GET /unit_prices/1/edit
  def edit
    @unit_price = UnitPrice.find(params[:id])
  end

  # POST /unit_prices
  # POST /unit_prices.json
  def create
    @unit_price = UnitPrice.new(params[:unit_price])

    respond_to do |format|
      if @unit_price.save
        format.html { redirect_to @unit_price, notice: 'Unit price was successfully created.' }
        format.json { render json: @unit_price, status: :created, location: @unit_price }
      else
        format.html { render action: "new" }
        format.json { render json: @unit_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /unit_prices/1
  # PUT /unit_prices/1.json
  def update
    @unit_price = UnitPrice.find(params[:id])

    respond_to do |format|
      if @unit_price.update_attributes(params[:unit_price])
        format.html { redirect_to @unit_price, notice: 'Unit price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unit_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_prices/1
  # DELETE /unit_prices/1.json
  def destroy
    @unit_price = UnitPrice.find(params[:id])
    @unit_price.destroy

    respond_to do |format|
      format.html { redirect_to unit_prices_url }
      format.json { head :no_content }
    end
  end
end
