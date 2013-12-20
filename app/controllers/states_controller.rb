class StatesController < ApplicationController
  def index
    @country = Country.find params[:country_id]
    @states = @country.states.alphabetical
  end
end
