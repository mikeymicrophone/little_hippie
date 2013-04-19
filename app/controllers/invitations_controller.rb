class InvitationsController < ApplicationController
  before_filter :authenticate_business_manager!, :except => [:create, :redeem, :exchange]
  
  def approve
    @invitation = Invitation.find params[:id]
    @invitation.approve!
    InvitationMailer.beta_invitation_approved(@invitation).deliver
    redirect_to :action => :index
  end
  
  def redeem
    @invitation = Invitation.find params[:id]
    if @invitation.code == params[:code] && @invitation.approved_at?
      @invitation.update_attribute :redeemed_at, Time.now
      redirect_to root_url(:invitation_redeemed => @invitation.id)
    else
      redirect_to root_url
    end
  end
  
  def exchange
    @invitation = Invitation.find_by_code params[:customer][:code]
    
    @customer = Customer.create :email => params[:customer][:email], :password => params[:customer][:password], :password_confirmation => params[:customer][:password], :first_name => @invitation.name.split(' ').first, :last_name => @invitation.name.split(' ')[1]
    sign_in @customer
    redirect_to root_url
  end
  
  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invitations }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(params[:invitation])

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to invitations_url }
      format.json { head :no_content }
    end
  end
end
