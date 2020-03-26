class Api::UsersController < ApiController
  
    def index
      users = User.all

      users = users.where(state_id: params[:state_id]) if params[:state_id]
      users = users.where(city_id: params[:city_id]) if params[:city_id]

      users = users.starts_with('first_name', params[:first_name]) if params[:first_name]
      users = users.starts_with('last_name', params[:last_name]) if params[:last_name]

      if params[:order] 
        if params[:order] == "city"
          if params[:desc] == "true"
            users = users.includes(:city).order("cities.name DESC")
          else
            users = users.includes(:city).order("cities.name ASC")
          end
        elsif params[:order] == "state"
          if params[:desc] == "true"
            users = users.includes(:state).order("states.name DESC")
          else
            users = users.includes(:state).order("states.name ASC")
          end
        else
          if params[:desc] == "true"
            users = users.order("#{params[:order]} DESC")
          else
            users = users.order("#{params[:order]} ASC")
          end
        end
      end
      paginate users, per_page: (params[:per_page]) ? params[:per_page] : 15
    end

    def show
      user = User.find(params[:id])
      render json: user
    end
end
  