class App::UserController < AppController
    
    def index
        render json: current_user
    end
     
end
  