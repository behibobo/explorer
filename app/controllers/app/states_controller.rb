class App::StatesController < ApplicationController
    skip_before_action :authenticate_request, only: [:index, :citities], raise: false
  
    def index
        states = State.all
        render json: states.to_json
    end
  
    def cities
        cities = City.where(state_id: params[:state_id])
        render json: cities.to_json
    end
end
  