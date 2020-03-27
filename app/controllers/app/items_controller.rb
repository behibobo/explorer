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

    def last_items
        item_ids = ItemCode.where.not(gift: nil).pluck(:item_id)
        new_items = Item.where(id: item_ids).order(created_at: :desc).first(4)

        items = []
        new_items.each do |new_item|
            item = {
                scan_date: "",
                item_name: new_item.name,
                item_brand: new_item.brand,
                item_image: new_item.image_url,
                has_gift: true,
                gift_value: new_item.item_codes.where.not(gift: nil).first.gift.value,
            }
        items.push item
        end

        render json: items.to_json
    end

    def scan_item
        message = ""
        success = true
        code = ItemCode.find_by(uuid: params[:code])

        if code.user.nil?
            code.user = current_user
            code.scan_date = Date.today
            code.save!

            unless code.gift.nil?
                current_user.credit += code.gift.value
                current_user.save
            end
            message = "بارکد با موفقیت ثبت شد"
            success = true
        else
            success = false
            message = "این بارکد قبلا توسط خود شما در تاریخ #{code.scan_date.to_date.to_pdate.strftime("%A %d %b %Y ")} ثبت شده است" if code.user == current_user
            message = "این بارکد قبلا توسط کاربر دیگری در تاریخ #{code.scan_date.to_date.to_pdate.strftime("%A %d %b %Y ")} ثبت شده است" if code.user != current_user
        end

        item = {
            scan_date: code.scan_date.to_date.to_pdate.to_s,
            item_name: code.item.name,
            item_brand: code.item.brand,
            item_image: code.item.image_url,
            has_gift: !code.gift.nil?,
            gift_value: (!code.gift.nil?)? code.gift.value : "",
        }

        render json: {item: item, message: message, success: success }
    end
end
  