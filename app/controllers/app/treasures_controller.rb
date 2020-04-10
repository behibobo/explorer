class App::TreasuresController < AppController
    def index
        treasures = Treasure.where("required_credit < ?" , current_user.credit)
            .where('valid_to > ?', Time.now)

        render json: treasures.to_json 
    end
end
  