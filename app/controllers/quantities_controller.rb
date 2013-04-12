class QuantitiesController < ApplicationController
  # GET /quantities
  # GET /quantities.json
  def index
    @quantities = Quantity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quantities }
    end
  end

  # GET /quantities/1
  # GET /quantities/1.json
  def show
    @quantity = Quantity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quantity }
    end
  end

  # GET /quantities/new
  # GET /quantities/new.json
  def new
    @quantity = Quantity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quantity }
    end
  end

  # GET /quantities/1/edit
  def edit
    @quantity = Quantity.find(params[:id])
  end

  # POST /quantities
  # POST /quantities.json
  def create
    @quantity = Quantity.new(params[:quantity])

    respond_to do |format|
      if @quantity.save
        format.html { redirect_to @quantity, notice: 'Quantity was successfully created.' }
        format.json { render json: @quantity, status: :created, location: @quantity }
      else
        format.html { render action: "new" }
        format.json { render json: @quantity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quantities/1
  # PUT /quantities/1.json
  def update
    @quantity = Quantity.find(params[:id])

    respond_to do |format|
      if @quantity.update_attributes(params[:quantity])
        format.html { redirect_to @quantity, notice: 'Quantity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quantity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quantities/1
  # DELETE /quantities/1.json
  def destroy
    @quantity = Quantity.find(params[:id])
    @quantity.destroy

    respond_to do |format|
      format.html { redirect_to quantities_url }
      format.json { head :no_content }
    end
  end
end
