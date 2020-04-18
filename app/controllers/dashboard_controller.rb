class DashboardController < ApplicationController
    skip_before_action :authenticate_request, only: [:index], raise: false
    def index
        data = []
        states = State.all

        states.each do |state|
            cities = City.where(state_id: state.id)
                .pluck(:name)
            item = {
                state: state.name,
                cities: cities
            }

            data.push(item)
        end

        render json: data.to_json
    end
end
