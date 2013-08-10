class LikesController < ApplicationController
  before_filter :authenticate_business_manager!, :except => [:create]
  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @likes }
    end
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
    @like = Like.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/new
  # GET /likes/new.json
  def new
    @like = Like.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like }
    end
  end

  # GET /likes/1/edit
  def edit
    @like = Like.find(params[:id])
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(params[:like])
    if current_customer
      @like.customer = current_customer
    else
      if @like.for_product?
        session[:liked_product_ids] ||= []
        session[:liked_product_ids] << params[:like][:favorite_id]
      elsif @like.for_design?
        session[:liked_design_ids] ||= []
        session[:liked_design_ids] << params[:like][:favorite_id]
      elsif @like.for_banner?
        session[:liked_banner_ids] ||= []
        session[:liked_banner_ids] << params[:like][:favorite_id]
      end
    end
    @like.cart = current_cart
    @like.ip = request.remote_ip

    respond_to do |format|
      if @like.save
        format.js
        format.html { redirect_to @like, notice: 'Like was successfully created.' }
        format.json { render json: @like, status: :created, location: @like }
      else
        format.js   { render :nothing => true }
        format.html { render action: "new" }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /likes/1
  # PUT /likes/1.json
  def update
    @like = Like.find(params[:id])

    respond_to do |format|
      if @like.update_attributes(params[:like])
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    respond_to do |format|
      format.html { redirect_to likes_url }
      format.json { head :no_content }
    end
  end
end
