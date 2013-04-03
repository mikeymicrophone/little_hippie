class FriendEmailsController < ApplicationController
  # GET /friend_emails
  # GET /friend_emails.json
  def index
    @friend_emails = FriendEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friend_emails }
    end
  end

  # GET /friend_emails/1
  # GET /friend_emails/1.json
  def show
    @friend_email = FriendEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friend_email }
    end
  end

  # GET /friend_emails/new
  # GET /friend_emails/new.json
  def new
    @friend_email = FriendEmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friend_email }
    end
  end

  # GET /friend_emails/1/edit
  def edit
    @friend_email = FriendEmail.find(params[:id])
  end

  # POST /friend_emails
  # POST /friend_emails.json
  def create
    @friend_email = FriendEmail.new(params[:friend_email])
    @friend_email.customer = current_customer

    respond_to do |format|
      if @friend_email.save
        format.js
        format.html { redirect_to @friend_email, notice: 'Friend email was successfully created.' }
        format.json { render json: @friend_email, status: :created, location: @friend_email }
      else
        format.html { render action: "new" }
        format.json { render json: @friend_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friend_emails/1
  # PUT /friend_emails/1.json
  def update
    @friend_email = FriendEmail.find(params[:id])

    respond_to do |format|
      if @friend_email.update_attributes(params[:friend_email])
        format.html { redirect_to @friend_email, notice: 'Friend email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @friend_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_emails/1
  # DELETE /friend_emails/1.json
  def destroy
    @friend_email = FriendEmail.find(params[:id])
    @friend_email.destroy

    respond_to do |format|
      format.html { redirect_to friend_emails_url }
      format.json { head :no_content }
    end
  end
end
