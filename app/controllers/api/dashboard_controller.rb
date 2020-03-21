class Api::DashboardController < ApiController
  
    def index
        all_users = User.count
        today_users = User.where(created_at: Date.today()).count
        states = State.all.order(:id)
        render json: {
            all_users: all_users,
            today_users: today_users,
            states: ActiveModelSerializers::SerializableResource.new(states)
        }
    end

    def state_users
        cities = City.order(:id).where(state_id: params[:id])
        render json: {
            cities: ActiveModelSerializers::SerializableResource.new(cities)

        }
    end

    def state
      @states = State.all
      render json: @states
    end

    def city
        @cities = City.where(state_id: params[:state_id])
        render json: @cities
    end
end
  