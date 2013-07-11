class MetaDescriptionsController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /meta_descriptions
  # GET /meta_descriptions.json
  def index
    @meta_descriptions = MetaDescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meta_descriptions }
    end
  end

  # GET /meta_descriptions/1
  # GET /meta_descriptions/1.json
  def show
    @meta_description = MetaDescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meta_description }
    end
  end

  # GET /meta_descriptions/new
  # GET /meta_descriptions/new.json
  def new
    @meta_description = MetaDescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meta_description }
    end
  end

  # GET /meta_descriptions/1/edit
  def edit
    @meta_description = MetaDescription.find(params[:id])
  end

  # POST /meta_descriptions
  # POST /meta_descriptions.json
  def create
    routing_params = MetaDescription.parse_url(params[:meta_description].delete(:url))
    routing_params[:resource_id] = routing_params.delete(:id)
    @meta_description = MetaDescription.new(params[:meta_description].merge(routing_params))

    respond_to do |format|
      if @meta_description.save
        format.html { redirect_to @meta_description, notice: 'Meta description was successfully created.' }
        format.json { render json: @meta_description, status: :created, location: @meta_description }
      else
        format.html { render action: "new" }
        format.json { render json: @meta_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meta_descriptions/1
  # PUT /meta_descriptions/1.json
  def update
    @meta_description = MetaDescription.find(params[:id])

    respond_to do |format|
      if @meta_description.update_attributes(params[:meta_description])
        format.html { redirect_to @meta_description, notice: 'Meta description was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meta_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meta_descriptions/1
  # DELETE /meta_descriptions/1.json
  def destroy
    @meta_description = MetaDescription.find(params[:id])
    @meta_description.destroy

    respond_to do |format|
      format.html { redirect_to meta_descriptions_url }
      format.json { head :no_content }
    end
  end
end
