class ContentPagesController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:show, :display]
  # GET /content_pages
  # GET /content_pages.json
  def index
    @content_pages = [ContentPage.navigation]
    ContentPage.count.times do |index|
      content = @content_pages[index - 1]
      Rails.logger.debug "content is #{content.name}"
      @content_pages.insert index, *content.children.ordered unless content.instance_variable_get('@expanded')
      content.instance_variable_set('@expanded', true)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @content_pages }
    end
  end

  def display
    @content_page = ContentPage.find_by_slug params[:id]
    @content_page ||= ContentPage.find params[:id]
    @title = if @content_page.html_title.present?
      @content_page.html_title
    else
      @content_page.title
    end
    render :layout => 'customer'
  end

  # GET /content_pages/1
  # GET /content_pages/1.json
  def show
    @content_page = ContentPage.find(params[:id])

    respond_to do |format|
      format.html do
        if current_product_manager || current_business_manager
          render
        else
          render :layout => 'customer', :action => 'display'
        end
      end
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
        format.html { redirect_to @content_page, notice: 'Content page has been created.' }
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
        format.html { redirect_to @content_page, notice: 'Content page has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content_page.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @content_page = ContentPage.find params[:id]
    @content_page.move_higher
    redirect_to :action => :index
  end

  def move_down
    @content_page = ContentPage.find params[:id]
    @content_page.move_lower
    redirect_to :action => :index
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
