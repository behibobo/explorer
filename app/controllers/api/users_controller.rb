class Api::UsersController < ApiController
  
    def index
      users = User.all

      users = users.where(state_id: params[:state_id]) if params[:state_id]
      users = users.where(city_id: params[:city_id]) if params[:city_id]

      users = users.starts_with('first_name', params[:first_name]) if params[:first_name]
      users = users.starts_with('last_name', params[:last_name]) if params[:last_name]
      users = users.contains('mobile', params[:mobile]) if params[:mobile]

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

    def update_credit
      user = User.find(params[:id])
      user.credit += params[:amount]
      if user.save

        UserTransaction.create(
          amount: params[:amount],
          user: user,
          transaction_type: "charge_by_admin",
          credit: user.credit
        )
        render json: user
        return
      end
      render json: user.errors, status: :unprocessable_entity
    end

    def user_transaction
      all = UserTransaction.where(user_id: params[:id])
        .order(created_at: :desc)

      render json: all
    end

    
    def purchased_loplobs
      all = PurchasedLoplob.where(user_id: params[:id])
        .order(date: :desc)

        render json: all
    end

    def found_treasures
      all = FoundTreasure.where(user_id: params[:id])
        .order(date: :desc)
        render json: all
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
    end 
end
  