class ArtworkImagesController < ApplicationController
  def index
    @artwork_images = ArtworkImage.page params[:page]
  end
  
  def show
    @artwork_image = ArtworkImage.find params[:id]
  end
  
  def new
    @artwork_image = ArtworkImage.new params[:artwork_image]
  end
  
  def edit
    @artwork_image = ArtworkImage.find params[:id]
  end
  
  def create
    @artwork_image = ArtworkImage.create params[:artwork_image]
    redirect_to @artwork_image
  end
  
  def update
    @artwork_image = ArtworkImage.find params[:id]
    @artwork_image.update_attributes params[:artwork_image]
    redirect_to @artwork_image
  end
  
  def destroy
    @artwork_image = ArtworkImage.find params[:id]
    @artwork_image.destroy
    redirect_to :action => :index
  end
end
