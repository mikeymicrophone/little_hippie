class FulfillmentController < ApplicationController
  
  def new_orders
    orders = Charge.ready_for_old_glory.map(&:id)
    respond_to do |format|
      format.json { render :json => orders }
    end
  end
end
