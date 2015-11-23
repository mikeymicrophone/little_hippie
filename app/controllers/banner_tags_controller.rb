class BannerTagsController < ApplicationController
  # GET /banner_tags
  # GET /banner_tags.json
  def index
    @banner_tags = if params[:design_id]
      Design.find(params[:design_id]).banner_tags.page(params[:page])
    elsif params[:body_style_id]
      BodyStyle.find(params[:body_style_id]).banner_tags.page(params[:page])
    elsif params[:size_id]
      Size.find(params[:size_id]).banner_tags.page(params[:page])
    elsif params[:color_id]
      Color.find(params[:color_id]).banner_tags.page(params[:page])
    elsif params[:product_id]
      Product.find(params[:product_id]).banner_tags.page(params[:page])
    elsif params[:product_color_id]
      ProductColor.find(params[:product_color_id]).banner_tags.page(params[:page])
    elsif params[:garment_id]
      Garment.find(params[:garment_id]).banner_tags.page(params[:page])
    else
      BannerTag.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banner_tags }
    end
  end

  # GET /banner_tags/1
  # GET /banner_tags/1.json
  def show
    @banner_tag = BannerTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @banner_tag }
    end
  end

  # GET /banner_tags/new
  # GET /banner_tags/new.json
  def new
    @banner_tag = BannerTag.new :banner_id => params[:banner_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @banner_tag }
    end
  end

  # GET /banner_tags/1/edit
  def edit
    @banner_tag = BannerTag.find(params[:id])
    if @banner_tag.tag_type == 'Product'
      @banner_tag.product_code = @banner_tag.tag.code
    end
  end

  # POST /banner_tags
  # POST /banner_tags.json
  def create
    @banner_tag = BannerTag.new(params[:banner_tag])

    respond_to do |format|
      if @banner_tag.save
        format.html { redirect_to @banner_tag, notice: 'Banner tag was successfully created.' }
        format.json { render json: @banner_tag, status: :created, location: @banner_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @banner_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banner_tags/1
  # PUT /banner_tags/1.json
  def update
    @banner_tag = BannerTag.find(params[:id])

    respond_to do |format|
      if @banner_tag.update_attributes(params[:banner_tag])
        format.html { redirect_to @banner_tag, notice: 'Banner tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banner_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banner_tags/1
  # DELETE /banner_tags/1.json
  def destroy
    @banner_tag = BannerTag.find(params[:id])
    @banner_tag.destroy

    respond_to do |format|
      format.html { redirect_to banner_tags_url }
      format.json { head :no_content }
    end
  end
end
