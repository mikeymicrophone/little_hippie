class ColorsController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /colors
  # GET /colors.json
  def index
    @colors = if params[:sort]
      Color.order params[:sort]
    else
      Color.ordered
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @colors }
    end
  end

  # GET /colors/1
  # GET /colors/1.json
  def show
    @color = Color.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @color }
    end
  end

  # GET /colors/new
  # GET /colors/new.json
  def new
    @color = Color.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @color }
    end
  end

  # GET /colors/1/edit
  def edit
    @color = Color.find(params[:id])
  end

  # POST /colors
  # POST /colors.json
  def create
    @color = Color.new(params[:color])

    respond_to do |format|
      if @color.save
        format.html { redirect_to @color, notice: 'Color has been created.' }
        format.json { render json: @color, status: :created, location: @color }
      else
        format.html { render action: "new" }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /colors/1
  # PUT /colors/1.json
  def update
    @color = Color.find(params[:id])

    respond_to do |format|
      if @color.update_attributes(params[:color])
        format.html { redirect_to @color, notice: 'Color has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @color = Color.find(params[:id])
    @color.move_higher
    redirect_to :action => 'index'
  end
  
  def move_down
    @color = Color.find(params[:id])
    @color.move_lower
    redirect_to :action => 'index'
  end

  # DELETE /colors/1
  # DELETE /colors/1.json
  def destroy
    @color = Color.find(params[:id])
    @color.destroy

    respond_to do |format|
      format.html { redirect_to colors_url }
      format.json { head :no_content }
    end
  end
end
