class BulletinsController < ApplicationController
  before_filter :authenticate_product_manager!, :except => [:browse, :detail]
  
  def browse
    @bulletins = Bulletin.active.alphabetical
    render :layout => 'customer'
  end
  
  def detail
    @bulletin = Bulletin.find params[:id]
    render :layout => 'customer'
  end
  
  def retrieve_facebook_posts
    client = Mogli::Client.new(ENV['FACEBOOK_API_TOKEN'])
    little_hippie_page = Mogli::Page.find(ENV['LITTLE_HIPPIE_FACEBOOK_PAGE_ID'], client)
    posts = little_hippie_page.posts
    posts.each do |post|
      message = post.message
      if message
        bulletin = Bulletin.create :title => 'Facebook Post', :content => post.message, :active => true, :teaser => message[/[^\.\!\?]*[\.\!\?]/], :facebook_image_url => post.picture, :facebook_post_id => post.id, :created_at => post.created_time
        home = ContentPage.find_by_slug 'home'
        BulletinPairing.create :bulletin => bulletin, :content_page => home
        likes = post.likes["data"]
        likes.each do |like_data|
          l = bulletin.likes.new :facebook_user_id => like_data["id"], :facebook_user_name => like_data["name"]
          if customer = Customer.find_by_facebook_id(like_data["id"])
            l.customer_id = customer.id
          end
          l.save
        end
      end
    end
    redirect_to :action => :index
  end
  
  # GET /bulletins
  # GET /bulletins.json
  def index
    @bulletins = Bulletin.recent

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bulletins }
    end
  end

  # GET /bulletins/1
  # GET /bulletins/1.json
  def show
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bulletin }
    end
  end

  # GET /bulletins/new
  # GET /bulletins/new.json
  def new
    @bulletin = Bulletin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bulletin }
    end
  end

  # GET /bulletins/1/edit
  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  # POST /bulletins
  # POST /bulletins.json
  def create
    @bulletin = Bulletin.new(params[:bulletin])

    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to @bulletin, notice: 'Bulletin has been created.' }
        format.json { render json: @bulletin, status: :created, location: @bulletin }
      else
        format.html { render action: "new" }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bulletins/1
  # PUT /bulletins/1.json
  def update
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      if @bulletin.update_attributes(params[:bulletin])
        format.html { redirect_to @bulletin, notice: 'Bulletin has been updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletins/1
  # DELETE /bulletins/1.json
  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy

    respond_to do |format|
      format.html { redirect_to bulletins_url }
      format.json { head :no_content }
    end
  end
end
