class ContentPagesController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /content_pages
  # GET /content_pages.json
  def index
    @content_pages = ContentPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @content_pages }
    end
  end

  # GET /content_pages/1
  # GET /content_pages/1.json
  def show
    @content_page = ContentPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content_page }
    end
  end

  # GET /content_pages/new
  # GET /content_pages/new.json
  def new
    @content_page = ContentPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content_page }
    end
  end

  # GET /content_pages/1/edit
  def edit
    @content_page = ContentPage.find(params[:id])
  end

  # POST /content_pages
  # POST /content_pages.json
  def create
    @content_page = ContentPage.new(params[:content_page])

    respond_to do |format|
      if @content_page.save
        format.html { redirect_to @content_page, notice: 'Content page was successfully created.' }
        format.json { render json: @content_page, status: :created, location: @content_page }
      else
        format.html { render action: "new" }
        format.json { render json: @content_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /content_pages/1
  # PUT /content_pages/1.json
  def update
    @content_page = ContentPage.find(params[:id])

    respond_to do |format|
      if @content_page.update_attributes(params[:content_page])
        format.html { redirect_to @content_page, notice: 'Content page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_pages/1
  # DELETE /content_pages/1.json
  def destroy
    @content_page = ContentPage.find(params[:id])
    @content_page.destroy

    respond_to do |format|
      format.html { redirect_to content_pages_url }
      format.json { head :no_content }
    end
  end
end
