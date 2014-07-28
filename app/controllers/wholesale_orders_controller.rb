class WholesaleOrdersController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:order, :body_style, :design]
  before_filter :authenticate_reseller!, :only => [:order, :body_style, :design]
  
  def order
    @categories = Category.age_group
    @designs = Design.featured
    render :layout => 'customer'
  end
  
  def styles
    @categories = Category.age_group
    render :layout => 'customer'
  end
  
  def designs
    @designs = Design.featured
    render :layout => 'customer'
  end
  
  def cart
    render :layout => 'customer'
  end
  
  def body_style
    @body_style = BodyStyle.find params[:body_style_id]
    @products = @body_style.products.active
  end
  
  def design
    @design = Design.find params[:design_id]
    @products = @design.products.active.body_style_active
  end
  
  def sort_cart
    @wholesale_items = case params[:sort]
    when 'quantity'
      current_wholesale_order.wholesale_items.order('quantity desc')
    when 'name'
      current_wholesale_order.wholesale_items.sort_by { |item| item.name }
    when 'body_style'
      current_wholesale_order.wholesale_items.joins(:body_style).order('body_styles.position')
    when 'design'
      current_wholesale_order.wholesale_items.joins(:design).order('designs.name')
    when 'color'
      current_wholesale_order.wholesale_items.joins(:color).order('colors.position')
    when 'size'
      current_wholesale_order.wholesale_items.joins(:body_style_size).order('body_style_sizes.order')
    when 'unit price'
      current_wholesale_order.wholesale_items.sort_by { |item| item.unit_price }
    when 'line total'
      current_wholesale_order.wholesale_items.sort_by { |item| item.dollar_price }
    else
      current_wholesale_order.wholesale_items
    end
  end
  
  # GET /wholesale_orders
  # GET /wholesale_orders.json
  def index
    @wholesale_orders = if params[:reseller_id]
      Reseller.find(params[:reseller_id]).wholesale_orders
    else
      WholesaleOrder.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wholesale_orders }
    end
  end

  # GET /wholesale_orders/1
  # GET /wholesale_orders/1.json
  def show
    @wholesale_order = WholesaleOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wholesale_order }
    end
  end

  # GET /wholesale_orders/new
  # GET /wholesale_orders/new.json
  def new
    @wholesale_order = WholesaleOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wholesale_order }
    end
  end

  # GET /wholesale_orders/1/edit
  def edit
    @wholesale_order = WholesaleOrder.find(params[:id])
  end

  # POST /wholesale_orders
  # POST /wholesale_orders.json
  def create
    @wholesale_order = WholesaleOrder.new(params[:wholesale_order])

    respond_to do |format|
      if @wholesale_order.save
        format.html { redirect_to @wholesale_order, notice: 'Wholesale order was successfully created.' }
        format.json { render json: @wholesale_order, status: :created, location: @wholesale_order }
      else
        format.html { render action: "new" }
        format.json { render json: @wholesale_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wholesale_orders/1
  # PUT /wholesale_orders/1.json
  def update
    @wholesale_order = WholesaleOrder.find(params[:id])

    respond_to do |format|
      if @wholesale_order.update_attributes(params[:wholesale_order])
        format.html { redirect_to @wholesale_order, notice: 'Wholesale order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wholesale_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wholesale_orders/1
  # DELETE /wholesale_orders/1.json
  def destroy
    @wholesale_order = WholesaleOrder.find(params[:id])
    @wholesale_order.destroy

    respond_to do |format|
      format.html { redirect_to wholesale_orders_url }
      format.json { head :no_content }
    end
  end
end
