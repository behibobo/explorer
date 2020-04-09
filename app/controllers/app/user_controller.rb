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
            dob: current_user.dob&.to_date&.to_pdate&.to_s
        }

        data['user'] = user
        data['total_items'] = Item.count
        data['total_gifts'] = ItemCode.where.not(gift: nil).count
        data['min_gift'] = Gift.order(:value).first.value
        data['max_gift'] = Gift.order(:value).last.value
        render json: data.to_json
    end
     
end
  