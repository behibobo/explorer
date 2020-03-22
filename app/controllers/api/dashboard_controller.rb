class Api::DashboardController < ApiController
  
    def index
        if params[:state_id]
            user_count = User.where(state_id: params[:state_id]).count
            today_users = User.where(created_at: Date.today()).count
            data = City.order(:id).where(state_id: params[:state_id])

            chart = []
            (1..31).to_a.each do |index|
                
                val = {
                    day: index,
                    this: User.this_month(index, params[:state_id]),
                    last: User.last_month(index, params[:state_id]),
                }.to_h
                chart << val
            end

            render json: {
                user_count: user_count,
                today_users: today_users,
                shop_cpunt: Shop.where(state_id: params[:state_id]).count,
                data: ActiveModelSerializers::SerializableResource.new(data),
                chart: chart
            }
        else
            user_count = User.count
            today_users = User.where(created_at: Date.today()).count
            data = State.all.order(:id)

            chart = []
            (1..31).to_a.each do |index|
                
                val = {
                    day: index,
                    this: User.this_month(index),
                    last: User.last_month(index),
                }.to_h
                chart << val
            end


            render json: {
                user_count: user_count,
                today_users: today_users,
                shop_cpunt: Shop.count,
                data: ActiveModelSerializers::SerializableResource.new(data),
                chart: chart
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
  