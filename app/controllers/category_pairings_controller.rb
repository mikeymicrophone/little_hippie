class CategoryPairingsController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /category_pairings
  # GET /category_pairings.json
  def index
    @category_pairings = CategoryPairing.order(:content_page_id, :position)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_pairings }
    end
  end

  # GET /category_pairings/1
  # GET /category_pairings/1.json
  def show
    @category_pairing = CategoryPairing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_pairing }
    end
  end

  # GET /category_pairings/new
  # GET /category_pairings/new.json
  def new
    @category_pairing = CategoryPairing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_pairing }
    end
  end

  # GET /category_pairings/1/edit
  def edit
    @category_pairing = CategoryPairing.find(params[:id])
  end

  # POST /category_pairings
  # POST /category_pairings.json
  def create
    @category_pairing = CategoryPairing.new(params[:category_pairing])

    respond_to do |format|
      if @category_pairing.save
        format.html { redirect_to @category_pairing, notice: 'Category pairing has been created.' }
        format.json { render json: @category_pairing, status: :created, location: @category_pairing }
      else
        format.html { render action: "new" }
        format.json { render json: @category_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_pairings/1
  # PUT /category_pairings/1.json
  def update
    @category_pairing = CategoryPairing.find(params[:id])

    respond_to do |format|
      if @category_pairing.update_attributes(params[:category_pairing])
        format.html { redirect_to @category_pairing, notice: 'Category pairing has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_pairing.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def move_up
    @category_pairing = CategoryPairing.find params[:id]
    @category_pairing.move_higher
    redirect_to :action => :index
  end

  # DELETE /category_pairings/1
  # DELETE /category_pairings/1.json
  def destroy
    @category_pairing = CategoryPairing.find(params[:id])
    @category_pairing.destroy

    respond_to do |format|
      format.html { redirect_to category_pairings_url }
      format.json { head :no_content }
    end
  end
end
