class Api::DashboardController < ApiController
  
    def index
        if params[:state_id]
            user_count = User.where(state_id: params[:state_id]).count
            today_users = User.where(created_at: Date.today()).count
            data = City.order(:id).where(state_id: params[:state_id])
            render json: {
                user_count: user_count,
                today_users: today_users,
                data: ActiveModelSerializers::SerializableResource.new(data),
                chart: User.where(state_id: params[:state_id]).order('date(created_at)').group('date(created_at)').count
            }
        else
            user_count = User.count
            today_users = User.where(created_at: Date.today()).count
            data = State.all.order(:id)
            render json: {
                user_count: user_count,
                today_users: today_users,
                data: ActiveModelSerializers::SerializableResource.new(data),
                chart: User.order('date(created_at)').group('date(created_at)').count
            }
        end
        
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
  