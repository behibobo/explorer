class Api::DashboardController < ApiController
  
    def index
        gifts = ItemCode.where.not(gift: nil).count
        found_gifts = ItemCode.where.not(gift: nil).where.not(user: nil).count

        found_today = ItemCode.where.not(gift: nil).where(scan_date: Date.today)
        found_yesterday = ItemCode.where.not(gift: nil).where(scan_date: Date.yesterday)

        if params[:state_id]
            state_users = User.where(state_id: params[:state_id])
            today_users = User.where(created_at: Date.today()).count
            data = City.order(:id).where(state_id: params[:state_id])

            male = state_users.where(gender: 0).count
            female = state_users.where(gender: 1).count

            ages = state_users.all.map {|u| u.age }.uniq.sort().map {|a| {age: a, count: 0} }
            ages.each do |age|
                age[:count] = state_users.select {|u| u.age == age[:age]}.count
            end

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
                user_count: state_users.count,
                today_users: today_users,
                shop_count: Shop.where(state_id: params[:state_id]).count,
                data: ActiveModelSerializers::SerializableResource.new(data),
                gifts: gifts,
                found_gifts: found_gifts,
                chart: chart,
                male: male,
                female: female,
                ages: ages,
                found_today: ActiveModelSerializers::SerializableResource.new(found_today),
                found_yesterday: ActiveModelSerializers::SerializableResource.new(found_yesterday)

            }
        else
            users = User.all
            today_users = User.where(created_at: Date.today()).count
            data = State.all.order(:id)

            male = users.where(gender: 0).count
            female = users.where(gender: 1).count

            ages = users.all.map {|u| u.age }.uniq.sort().map {|a| {age: a, count: 0} }
            ages.each do |age|
                age[:count] = users.select {|u| u.age == age[:age]}.count
            end

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
                user_count: users.count,
                today_users: today_users,
                shop_count: Shop.count,
                data: ActiveModelSerializers::SerializableResource.new(data),
                gifts: gifts,
                found_gifts: found_gifts,
                chart: chart,
                male: male,
                female: female,
                ages: ages,
                found_today: ActiveModelSerializers::SerializableResource.new(found_today),
                found_yesterday: ActiveModelSerializers::SerializableResource.new(found_yesterday)
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
        @cities = City.order(:name).where(state_id: params[:state_id])
        render json: @cities
    end
end