class App::ItemsController < AppController
    def index
        codes = ItemCode.where(user: current_user)
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

        render json: items.to_json
    end
end
  