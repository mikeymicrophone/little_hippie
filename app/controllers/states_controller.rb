class StatesController < ApplicationController
  def index
    @country = Country.find_by_id params[:country_id]
    if @country
      @states_are_for_shipping_form = true
    else
      @country = Country.find_by_name params[:country_id]
    end
    @states = @country.states.alphabetical
  end
end
