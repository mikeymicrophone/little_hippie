class ProductsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => :detail
  
  def detail
    @product = Product.find params[:id]
    @product_colors = @product.product_colors
    render :layout => 'customer'
  end
  
  def search
    query = '%' + params[:query] + '%'
    @body_styles = BodyStyle.where "name like ?", query
    @designs = Design.where "name like ?", query
    @products = @body_styles.map(&:products).flatten | @designs.map(&:products).flatten
    render :action => 'index'
  end
  
  # GET /products
  # GET /products.json
  def index
    @products = if params[:body_style_id]
      BodyStyle.find(params[:body_style_id]).products.ordered
    elsif params[:design_id]
      Design.find(params[:design_id]).products.ordered
    else
      if params[:sort].present?
        session[:product_sort] = params[:sort]
      end
      if session[:product_sort]
        if session[:product_sort] == 'code'
          Product.order(:code)
        elsif session[:product_sort] == 'design_id'
          Design.alphabetical.map(&:products).flatten
        elsif session[:product_sort] == 'body_style_id'
          BodyStyle.alphabetical.map(&:products).flatten
        else
          Product.order(session[:product_sort])
        end
      else
        Product.ordered
      end
    end

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
