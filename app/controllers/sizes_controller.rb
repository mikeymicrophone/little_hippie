class SizesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /sizes
  # GET /sizes.json
  def index
    @sizes = Size.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sizes }
    end
  end

  # GET /sizes/1
  # GET /sizes/1.json
  def show
    @size = Size.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @size }
    end
  end

  # GET /sizes/new
  # GET /sizes/new.json
  def new
    @size = Size.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @size }
    end
  end

  # GET /sizes/1/edit
  def edit
    @size = Size.find(params[:id])
  end

  # POST /sizes
  # POST /sizes.json
  def create
    @size = Size.new(params[:size])

    respond_to do |format|
      if @size.save
        format.html { redirect_to @size, notice: 'Size was successfully created.' }
        format.json { render json: @size, status: :created, location: @size }
      else
        format.html { render action: "new" }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sizes/1
  # PUT /sizes/1.json
  def update
    @size = Size.find(params[:id])

    respond_to do |format|
      if @size.update_attributes(params[:size])
        format.html { redirect_to @size, notice: 'Size was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sizes/1
  # DELETE /sizes/1.json
  def destroy
    @size = Size.find(params[:id])
    @size.destroy

    respond_to do |format|
      format.html { redirect_to sizes_url }
      format.json { head :no_content }
    end
  end
end
