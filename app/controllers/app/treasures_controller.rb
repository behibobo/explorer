class App::TreasuresController < AppController
    def index
        treasures = Treasure.where("required_credit < ?" , current_user.credit)
            .where('valid_to > ?', Time.now)

        render json: treasures.to_json 
    end


    def found_treasures
        items = []
        current_user.found_treasures.order(created_at: :desc).each do |item|
            p = {
                id: item.id,
                value: item.value,
                date: item.date.to_date.to_pdate.to_s,
            }
        items.push p
        end
        render json: items.to_json
    end
end
  