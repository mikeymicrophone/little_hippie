class ItemsController < ApplicationController
  before_filter :authenticate_product_manager!, :only => [:index, :new, :show, :edit]
  
  def check_inventory
    begin
      @item = Item.find params[:id]
      @garment = @item.garment
      if @garment.inventory.andand.current_amount.andand.>= @item.quantity
        render :json => 'in_stock'
      elsif @garment.stashed?
        render :json => 'in_stock'
      else
        if @garment.inventory.andand.current_amount.andand.> 0
          render :json => "Only #{@garment.inventory.andand.current_amount} are in stock."
        else
          render :json => "None of these are in stock right now."
        end
      end
    rescue
      render :json => 'in_stock'
    end
  end
  
  # GET /items
  # GET /items.json
  def index
    @items = if params[:cart_id]
      Cart.find(params[:cart_id]).items
    elsif params[:customer_id]
      Customer.find(params[:customer_id]).items
    elsif params[:sort]
      case params[:sort]
      when 'cart_id'
        Item.order("cart_id #{params[:cart_sort_direction]}")
      when 'product_color_id'
        Item.order("product_color_id #{params[:product_color_sort_direction]}")
      when 'size_id'
        Item.order("size_id #{params[:size_sort_direction]}")
      when 'purchased'
        Item.order("charges.result #{params[:purchased_sort_direction]}").joins(:charges)
      when 'coupon'
        Item.order("coupons.name #{params[:coupon_sort_direction]}").joins(:coupons)
      end
    else
      Item
    end.order('created_at desc').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @stock = Stock.find_by_color_id_and_body_style_size_id(@item.color.id, @item.body_style_size.id)
    @item.garment = Garment.find_by_stock_id_and_design_id(@stock.id, @item.design.id)
    @item.cart = current_cart
    @item.set_default_quantity
        
    unless @item.cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
      @item.cart = @cart
    end
    
    if params[:moved_from_wishlist]
      current_customer.primary_wishlist.wishlist_items.find_by_product_color_id_and_size_id(@item.product_color_id, @item.size_id).destroy
    end

    identical_item = Item.find_by_product_color_id_and_size_id_and_cart_id(@item.product_color_id, @item.size_id, @item.cart_id)
    if identical_item
      identical_item.update_attribute(:quantity, identical_item.quantity + @item.quantity)
    else
      @item.save
    end

    respond_to do |format|
      format.html { redirect_to current_cart }
      format.json { render json: @item, status: :created, location: @item }
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.js
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.js   { render :action => 'update' }
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
