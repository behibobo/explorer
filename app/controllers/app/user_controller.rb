class App::UserController < AppController
    
    def index
        data = {}
        user = {
            first_name: current_user.first_name,
            last_name: current_user.last_name,
            credit: current_user.credit
        }


        codes = ItemCode.where(user: current_user).order(scan_date: :desc)
        items = []
        codes.each do |code|
            item = {
                scan_date: code.scan_date.to_date.to_pdate.to_s,
                item_name: code.item.name,
                item_brand: code.item.brand,
                item_image: code.item.image_url,
                has_gift: !code.gift.nil?,
                gift_value: (!code.gift.nil?)? code.gift.value : "",
            }
        items.push item
        end
        data['user'] = user
        data['items'] = items
        render json: data.to_json
    end
     
end
  