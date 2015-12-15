class LinksController < ApplicationController
  before_filter :authenticate_product_manager!
  def index
    @links = Link.all
  end
  
  def show
    @link = Link.find params[:id]
  end
  
  def new
    @link = Link.new
  end
  
  def edit
    @link = Link.find params[:id]
  end
  
  def create
    @link = Link.create params[:link]
    redirect_to @link
  end
  
  def update
    @link = Link.find params[:id]
    @link.update_attributes params[:link]
    redirect_to @link
  end
  
  def move_up
    @link = Link.find params[:id]
    @Link.move_higher
    redirect_to :action => 'index'
  end
  
  def move_down
    @link = Link.find params[:id]
    @Link.move_lower
    redirect_to :action => 'index'    
  end
  
  def destroy
    @link = Link.find params[:id]
    @link.destroy
    redirect_to :action => 'index'
  end
end
