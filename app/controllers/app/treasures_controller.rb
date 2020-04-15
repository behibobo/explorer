class App::TreasuresController < AppController
    def index
        treasures = Treasure.where("required_credit < ?" , current_user.credit)
            .where('valid_to > ?', Time.now)

        render json: treasures.to_json 
    end


    def found_treasures
        items = []
        treasures = FoundTreasure.where(user: current_user)
            .order(created_at: :desc)
            .limit(params[:limit])
            .offset(params[:offset])

        treasures.each do |item|
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
  