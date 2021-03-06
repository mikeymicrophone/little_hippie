class BannersController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:gallery, :display, :create]

  def gallery
    @banners = Banner.ordered.in_gallery
    render :layout => 'customer'
  end
  
  def display
    @banner = Banner.find params[:id]
    render :layout => 'customer'
  end
  
  # GET /banners
  # GET /banners.json
  def index
    @banners = if params[:filter]
      if params[:filter] == 'gallery'
        Banner.in_gallery
      else
        Banner.trivial
      end
    else
      Banner.trivial
    end
    
    @banners = if params[:sort]
      case params[:sort]
      when 'name'
        @banners.where("banners.name != 'Facebook Posted Image'").order "name #{params[:name_sort_direction]}"
      when 'gallery_position'
        @banners.order :gallery_position
      end
    elsif params[:name_pick]
      @banners.where(:name => params[:name_pick])
    elsif params[:banner_group] == 'featured_square'
      @banners.where("name ilike 'Featured%' or name ilike 'Square%'")
    else
      @banners.recent
    end.not_from_customers.page(params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banners }
    end
  end
  
  def ordering
    if (@orders = params[:items_ids]) && (@orders.present?)
      @orders = JSON.parse(params[:items_ids])
      if @orders.kind_of?(Array) && @orders.size > 0
        @orders.each_with_index do |id, index|
          Banner.find(id).update_attribute :gallery_position, index + 1
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to gallery_banners_path }
    end
  end
  
  def customers_index
    @banners = if params[:sort]
      case params[:sort]  
      when 'name'
        Banner.order "name #{params[:name_sort_direction]}"
      when 'gallery_position'
        Banner.order :gallery_position
      end
    else
      Banner.recent
    end.from_customers.page(params[:page])
    
    respond_to do |format|
      format.html { render 'index.html.erb' }
      format.json { render json: @banners }
    end
  end
  
  def search
    @banners = Banner.search params[:query]
  end

  # GET /banners/1
  # GET /banners/1.json
  def show
    @banner = Banner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /banners/new
  # GET /banners/new.json
  def new
    @banner = Banner.new

    respond_to do |format|
      format.js   { render :nothing => true }
      format.html # new.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /banners/1/edit
  def edit
    @banner = Banner.find(params[:id])
  end

  # POST /banners
  # POST /banners.json
  def create
    @banner = Banner.new(params[:banner])
    @banner.customer_id = current_customer.andand.id

    respond_to do |format|
      if @banner.save
        format.js
        format.html { redirect_to @banner, notice: 'Banner was successfully created.' }
        format.json { render json: @banner, status: :created, location: @banner }
      else
        format.html { render action: "new" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banners/1
  # PUT /banners/1.json
  def update
    @banner = Banner.find(params[:id])

    respond_to do |format|
      if @banner.update_attributes(params[:banner])
        format.html { redirect_to @banner, notice: 'Banner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up_in_gallery
    @banner = Banner.find params[:id]
    @banner.move_higher
    redirect_to :action => :index
  end
  
  def move_down_in_gallery
    @banner = Banner.find params[:id]
    @banner.move_lower
    redirect_to :action => :index
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    respond_to do |format|
      format.html { redirect_to banners_url }
      format.json { head :no_content }
    end
  end
  
  def delete
    @rows_to_remove = []
    params[:ids].split(',').each do |id|
      Banner.find(id).andand.destroy
      @rows_to_remove << id
    end
  end
end
