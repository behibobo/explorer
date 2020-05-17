class App::UserController < AppController
    
    def index
        data = {}
        user = {
            first_name: current_user.first_name,
            last_name: current_user.last_name,
            credit: current_user.credit,
            gender: current_user.gender,
            email: current_user.email,
            mobile: current_user.mobile,
            state: current_user&.state&.id,
            city: current_user&.city&.id,
            dob: current_user.dob&.to_date&.to_pdate&.to_s&.gsub("-", "/")
        }

        data['user'] = user
        data['total_items'] = Item.count
        data['total_gifts'] = ItemCode.where.not(gift: nil).count
        data['min_gift'] = Gift.order(:value).first.value
        data['max_gift'] = Gift.order(:value).last.value
        render json: data.to_json
    end
     
    def update
        current_user.update(user_params)
        if params[:dob]
            d = params[:dob].split("/")
            date = PDate.new(d[0].to_i, d[1].to_i, d[2].to_i).to_date
            current_user.update(dob: date)
        end

        if params[:state] && params[:city]
            state = State.find(params[:state].to_i)
            city = City.find(params[:city].to_i)
            current_user.update(state_id: state.id, city_id: city.id)
        end

        user = {
            first_name: current_user.first_name,
            last_name: current_user.last_name,
            credit: current_user.credit,
            gender: current_user.gender,
            email: current_user.email,
            mobile: current_user.mobile,
            state: current_user&.state&.id,
            city: current_user&.city&.id,
            dob: current_user.dob&.to_date&.to_pdate&.to_s&.gsub("-", "/")
        }
        render json: user.to_json
    end

    def home
        shops = Shop.all
        items = Item.all
        treasures = Treasure.all
        if params[:state_id] && params[:state_id].to_i != 0
            shops = shops.where(state_id: params[:state_id].to_i)
            new_items = Item.where(shop: nil)
            items = shops.map {|shop| shop.items }.flatten
            items = items + new_items
            treasures = treasures.where(state_id: params[:state_id].to_i)
        end
        data = {}

        item_ids = items.pluck(:id)
        data['total_items'] = items.count
        data['total_gifts'] = items.map {|item| item.item_codes.where.not(gift: nil) }.flatten.count
        data['found_gifts'] = items.map {|item| item.item_codes.where.not(gift: nil).where.not(user: nil) }.flatten.count
        data['percentage'] = (data['found_gifts'] * 100) / data['total_gifts']
        data['treasures'] = treasures.count

        render json: data.to_json
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :gender)
    end
end
  