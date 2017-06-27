class BlanketsController < ApplicationController
  before_filter :authenticate_reseller!
  before_filter :reseller_can_buy_blankets?
  def input
    @blanket = BodyStyle.find_by :code =>  'RUG'
    @blankets = @blanket.products
  end
  
  def order
    @shipping_address = ShippingAddress.find_or_create_by_street_and_city_and_state_id(params[:shipping_address])
    @wholesale_order = WholesaleOrder.create :reseller => current_reseller, :shipping_address => @shipping_address
    
    params.each do |name, value|
      if name =~ /blanket_(\d+)/ && value.to_i > 0
        product = Product.find $1
        wholesale_item = WholesaleItem.create :garment => product.garments.first, :wholesale_order => @wholesale_order, :quantity => value.to_i
      end
    end
    @wholesale_order.submit!
    redirect_to review_blankets_path(@wholesale_order)
  end
  
  def review
    @wholesale_order = WholesaleOrder.find params[:id]
  end
  
  def reseller_can_buy_blankets?
    current_reseller.can_buy_blankets?
  end
end
