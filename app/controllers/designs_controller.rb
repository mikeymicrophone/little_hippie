class DesignsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => :browse

  def browse
    @designs = Design.all
    render :layout => 'customer'
  end
  
  # GET /designs
  # GET /designs.json
  def index
    @designs = Design.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @designs }
    end
  end

  # GET /designs/1
  # GET /designs/1.json
  def show
    @design = Design.find(params[:id])
    @products = @design.products

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @design }
    end
  end

  # GET /designs/new
  # GET /designs/new.json
  def new
    @design = Design.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @design }
    end
  end

  # GET /designs/1/edit
  def edit
    @design = Design.find(params[:id])
  end

  # POST /designs
  # POST /designs.json
  def create
    @design = Design.new(params[:design])

    respond_to do |format|
      if @design.save
        format.html { redirect_to @design, notice: 'Design has been created.' }
        format.json { render json: @design, status: :created, location: @design }
      else
        format.html { render action: "new" }
        format.json { render json: @design.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /designs/1
  # PUT /designs/1.json
  def update
    @design = Design.find(params[:id])

    respond_to do |format|
      if @design.update_attributes(params[:design])
        format.html { redirect_to @design, notice: 'Design has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @design.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @design = Design.find(params[:id])
    @design.move_higher
    redirect_to :action => 'index'
  end

  # DELETE /designs/1
  # DELETE /designs/1.json
  def destroy
    @design = Design.find(params[:id])
    @design.destroy

    respond_to do |format|
      format.html { redirect_to designs_url }
      format.json { head :no_content }
    end
  end
end
