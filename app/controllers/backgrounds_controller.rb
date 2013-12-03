class BackgroundsController < ApplicationController
  # GET /backgrounds
  # GET /backgrounds.json
  def index
    @backgrounds = Background.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backgrounds }
    end
  end

  # GET /backgrounds/1
  # GET /backgrounds/1.json
  def show
    @background = Background.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @background }
    end
  end

  # GET /backgrounds/new
  # GET /backgrounds/new.json
  def new
    @background = Background.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @background }
    end
  end

  # GET /backgrounds/1/edit
  def edit
    @background = Background.find(params[:id])
  end

  # POST /backgrounds
  # POST /backgrounds.json
  def create
    @background = Background.new(params[:background])

    respond_to do |format|
      if @background.save
        format.html { redirect_to @background, notice: 'Background was successfully created.' }
        format.json { render json: @background, status: :created, location: @background }
      else
        format.html { render action: "new" }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backgrounds/1
  # PUT /backgrounds/1.json
  def update
    @background = Background.find(params[:id])

    respond_to do |format|
      if @background.update_attributes(params[:background])
        format.html { redirect_to @background, notice: 'Background was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backgrounds/1
  # DELETE /backgrounds/1.json
  def destroy
    @background = Background.find(params[:id])
    @background.destroy

    respond_to do |format|
      format.html { redirect_to backgrounds_url }
      format.json { head :no_content }
    end
  end
end
