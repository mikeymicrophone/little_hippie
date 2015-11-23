class FulfillmentController < ApplicationController
  
  def new_orders
    orders = Charge.ready_for_old_glory.pertinent_to_old_glory.map(&:id)
    respond_to do |format|
      format.json { render :json => orders }
    end
  end
  
  def fulfillment_details
    @charge = Charge.find params[:id]
    @cart = @charge.cart
    @shipping_address = @cart.apparent_primary_shipping_address
    @charge.update_attribute :result, 'Old Glory notified'
  end
  
  def tracking_number
    @charge = Charge.find params[:id]
    @cart = @charge.cart
    @cart.update_attribute :tracking_number, params[:tracking_number]
    if @cart.gift_note.present?
      ShipmentMailer.gift_message(@cart.id).deliver
    else
      ShipmentMailer.shipment_tracking(@cart.id).deliver
    end
    render :nothing => true
  end
end
