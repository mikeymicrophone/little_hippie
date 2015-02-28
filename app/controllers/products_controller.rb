class ProductsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:detail, :customer_search, :check_inventory, :filter]
  # before_filter :authenticate_customer!, :only => [:detail, :customer_search]
  
  def detail
    @product = Product.find params[:id]
    @product_colors = @product.product_colors
    @similar_items = @product.similar_items
    @title = @product.name
    render :layout => 'customer'
  end
  
  def filter
    filter_criteria = params[:scope_names]
    filter_criteria.reject! { |criteria| criteria =~ /category/ } if filter_criteria.any? { |criteria| criteria =~ /body_style/ }
    filter_criteria.reject! { |criteria| criteria =~ /body_style_\d/ } if filter_criteria.any? { |criteria| criteria =~ /body_style_size/ }
    scopes = filter_criteria.group_by { |criteria| criteria =~ /(\D+)/; $1 }
    cool_objects = scopes.map do |scope_type, scope_list|
      scope_type.classify.constantize.limit(10).where(:id => scope_list.map { |s| s =~ /(\d+)/; $1 })
    end
    @product_colors = cool_objects.flatten.map(&:product_colors).flatten.uniq
    @new_filters = {}
    filter_criteria.each do |criteria|
      if criteria =~ /category_(\d+)/
        (@new_filters[criteria] ||= []).concat Category.find($1).body_styles
      elsif criteria =~ /body_style_(\d+)/
        (@new_filters[criteria] ||= []).concat BodyStyle.find($1).colors
        @new_filters[criteria].concat BodyStyle.find($1).body_style_sizes
      end
    end
  end
  
  def customer_search
    price = params[:query].split.select { |q| q.to_i > 0 }.map(&:to_i).first
    
    if price
      params[:query] = params[:query].split.select { |q| q.to_i == 0 }.join(' ')
    end
    
    @products = Product.search params[:query]
    @colors = Color.search params[:query]
    @product_colors = (@products.map { |p| p.product_colors.active_product }.flatten + @colors.map { |c| c.product_colors.active_product }.flatten).uniq
    
    if price
      @products_below_price = Product.where('price < ?', price * 101)
      @product_colors_below_price = @products_below_price.map(&:product_colors).flatten.uniq
      @product_colors = @product_colors & @product_colors_below_price
    end

    render :template => 'categories/detail', :layout => 'customer'
  end
  
  def search
    @products = Product.search params[:query]
    render :action => 'index'
  end
  
  def check_inventory
    @product = Product.find params[:id]
    
    @inventory = @product.inventory_snapshots
    # @stash = @product.stashed_inventories
    @colors = @inventory.group_by(&:color)
    @sizes = @inventory.group_by(&:size)
    
    color_json = Hash[@colors.map { |c, sizes| [c.id, Hash[sizes.map { |inv| [inv.size.id, inv.current_amount] }]] }]
    
    # @stash.each do |si|
    #   color_json[si.color.id] ||= {}
    #   color_json[si.color.id][si.size.id] = 6
    # end
    
    render :json => color_json
  end
  
  def generate_image
    params[:scale] = 50 if params[:scale].blank?
    params[:top_offset] = '0' if params[:top_offset].blank?
    params[:left_offset] = '0' if params[:left_offset].blank?
    
    @product = Product.find params[:id]
    @product_image = @product.generate_image params[:scale], params[:top_offset], params[:left_offset], params[:name], current_product_manager
    
    respond_to do |format|
      format.js
      format.html { send_data File.open("./tmp/product_image.png").read, :type => 'image/png', :disposition => 'inline' }
    end
  end
  
  def pick_landing_color
    @product = Product.find params[:id]
  end
  
  def choose_landing_color
    @product = Product.find params[:id]
    @product.landing_color_id = params[:color_id]
    @product.save
    redirect_to @product
  end
  
  # GET /products
  # GET /products.json
  def index
    @products = if params[:body_style_id]
      BodyStyle.find(params[:body_style_id]).products.ordered
    elsif params[:design_id]
      Design.find(params[:design_id]).products.ordered
    elsif params[:size_id]
      Size.find(params[:size_id]).products.ordered
    elsif params[:color_id]
      Color.find(params[:color_id]).products.ordered
    else
      if params[:sort].present?
        session[:product_sort] = params[:sort]
      end
      if session[:product_sort]
        if session[:product_sort] == 'code'
          Product.order(:code)
        elsif session[:product_sort] == 'design_id'
          Product.joins(:design).order('designs.name')
        elsif session[:product_sort] == 'body_style_id'
          Product.joins(:body_style).order('body_styles.name')
        else
          Product.order(session[:product_sort])
        end
      else
        Product.ordered
      end
    end.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @product_colors = @product.product_colors

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end
  
  def add_colors_for
    @product = Product.find params[:id]
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product has been created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @product = Product.find params[:id]
    @product.move_higher
    redirect_to :action => :index
  end

  def move_down
    @product = Product.find params[:id]
    @product.move_lower
    redirect_to :action => :index
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
