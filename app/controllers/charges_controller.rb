class ChargesController < ApplicationController
  before_filter :authenticate_product_manager!, :only => [:index, :edit, :update, :destroy]
  # GET /charges
  # GET /charges.json
  def index
    @charges = Charge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charges }
    end
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
    @charge = Charge.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'customer' }
      format.json { render json: @charge }
    end
  end

  # GET /charges/new
  # GET /charges/new.json
  def new
    @charge = Charge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charge }
    end
  end

  # GET /charges/1/edit
  def edit
    @charge = Charge.find(params[:id])
  end

  # POST /charges
  # POST /charges.json
  def create
    @charge = Charge.new(params[:charge])

    respond_to do |format|
      if @charge.save
        begin
          if params[:save_card]
            identifier = current_customer.andand.email
            identifier ||= "cart #{@charge.cart_id}"
            stripe_customer = Stripe::Customer.create(:description => "Customer record for #{identifier}.\n#{params[:company]}\n#{params[:phone]}", :card => @charge.token)
            stripe_charge = Stripe::Charge.create(
              :amount => @charge.amount * 100,
              :currency => "usd",
              :customer => stripe_customer.id,
              :description => "cart ##{session[:cart_id]}"
            )
            if current_customer
              current_customer.credit_cards.create :stripe_customer_id => stripe_customer.id
            end
          else
            stripe_charge = Stripe::Charge.create(
              :amount => @charge.amount * 100,
              :currency => "usd",
              :card => @charge.token,
              :description => "cart ##{session[:cart_id]}"
            )
          end
        rescue Stripe::CardError => card_error
          @notice = card_error.message
        else
          current_cart.update_attribute :ip_address, request.remote_ip
          session[:cart_id] = nil
          @charge.update_attribute :result, 'complete'
          @notice = 'Your order is complete.'
        end
        format.html { redirect_to @charge, notice: @notice }
        format.json { render json: @charge, status: :created, location: @charge }
      else
        format.html { render action: "new" }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charges/1
  # PUT /charges/1.json
  def update
    @charge = Charge.find(params[:id])

    respond_to do |format|
      if @charge.update_attributes(params[:charge])
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge = Charge.find(params[:id])
    @charge.destroy

    respond_to do |format|
      format.html { redirect_to charges_url }
      format.json { head :no_content }
    end
  end
end
