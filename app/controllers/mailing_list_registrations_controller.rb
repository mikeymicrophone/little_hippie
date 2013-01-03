class MailingListRegistrationsController < ApplicationController
  # GET /mailing_list_registrations
  # GET /mailing_list_registrations.json
  def index
    @mailing_list_registrations = MailingListRegistration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mailing_list_registrations }
    end
  end
  
  def import
    csv = params[:csv][:data]
    data = csv.read
    CSV.parse(data, :headers => :first_row) do |lead|
      debugger
      MailingListRegistration.create :first_name => lead['first_name'],
        :last_name => lead['last_name'],
        :email => lead['email'],
        :street => lead['address1'],
        :street2 => lead['address2'],
        :city => lead['city'],
        :state => lead['state'],
        :zip => lead['zip'],
        :festival => lead['festival']
    end
    redirect_to :action => :index
  end

  # GET /mailing_list_registrations/1
  # GET /mailing_list_registrations/1.json
  def show
    @mailing_list_registration = MailingListRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mailing_list_registration }
    end
  end

  # GET /mailing_list_registrations/new
  # GET /mailing_list_registrations/new.json
  def new
    @mailing_list_registration = MailingListRegistration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mailing_list_registration }
    end
  end

  # GET /mailing_list_registrations/1/edit
  def edit
    @mailing_list_registration = MailingListRegistration.find(params[:id])
  end

  # POST /mailing_list_registrations
  # POST /mailing_list_registrations.json
  def create
    @mailing_list_registration = MailingListRegistration.new(params[:mailing_list_registration])

    unless @mailing_list_registration.valid?
      @mailing_list_registration = MailingListRegistration.find_by_email(params[:mailing_list_registration][:email].downcase)
    end

    respond_to do |format|
      if @mailing_list_registration.save
        format.js
        format.html { redirect_to @mailing_list_registration, notice: 'Mailing list registration was successfully created.' }
        format.json { render json: @mailing_list_registration, status: :created, location: @mailing_list_registration }
      else
        format.html { render action: "new" }
        format.json { render json: @mailing_list_registration.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def physical
    @mailing_list_registration = MailingListRegistration.find params[:id]
    render :layout => 'customer'
  end

  # PUT /mailing_list_registrations/1
  # PUT /mailing_list_registrations/1.json
  def update
    @mailing_list_registration = MailingListRegistration.find(params[:id])

    respond_to do |format|
      if @mailing_list_registration.update_attributes(params[:mailing_list_registration])
        format.js
        format.html { redirect_to root_url, notice: 'Thank you.  You will receive future catalogs by mail.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mailing_list_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailing_list_registrations/1
  # DELETE /mailing_list_registrations/1.json
  def destroy
    @mailing_list_registration = MailingListRegistration.find(params[:id])
    @mailing_list_registration.destroy

    respond_to do |format|
      format.html { redirect_to mailing_list_registrations_url }
      format.json { head :no_content }
    end
  end
end
