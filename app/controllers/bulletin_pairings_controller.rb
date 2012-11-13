class BulletinPairingsController < ApplicationController
  before_filter :authenticate_product_manager!
  # GET /bulletin_pairings
  # GET /bulletin_pairings.json
  def index
    @bulletin_pairings = BulletinPairing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bulletin_pairings }
    end
  end

  # GET /bulletin_pairings/1
  # GET /bulletin_pairings/1.json
  def show
    @bulletin_pairing = BulletinPairing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bulletin_pairing }
    end
  end

  # GET /bulletin_pairings/new
  # GET /bulletin_pairings/new.json
  def new
    @bulletin_pairing = BulletinPairing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bulletin_pairing }
    end
  end

  # GET /bulletin_pairings/1/edit
  def edit
    @bulletin_pairing = BulletinPairing.find(params[:id])
  end

  # POST /bulletin_pairings
  # POST /bulletin_pairings.json
  def create
    @bulletin_pairing = BulletinPairing.new(params[:bulletin_pairing])

    respond_to do |format|
      if @bulletin_pairing.save
        format.html { redirect_to @bulletin_pairing, notice: 'Bulletin pairing has been created.' }
        format.json { render json: @bulletin_pairing, status: :created, location: @bulletin_pairing }
      else
        format.html { render action: "new" }
        format.json { render json: @bulletin_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bulletin_pairings/1
  # PUT /bulletin_pairings/1.json
  def update
    @bulletin_pairing = BulletinPairing.find(params[:id])

    respond_to do |format|
      if @bulletin_pairing.update_attributes(params[:bulletin_pairing])
        format.html { redirect_to @bulletin_pairing, notice: 'Bulletin pairing has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bulletin_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletin_pairings/1
  # DELETE /bulletin_pairings/1.json
  def destroy
    @bulletin_pairing = BulletinPairing.find(params[:id])
    @bulletin_pairing.destroy

    respond_to do |format|
      format.html { redirect_to bulletin_pairings_url }
      format.json { head :no_content }
    end
  end
end
