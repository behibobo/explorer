class Api::AuthController < ApiController
    skip_before_action :authenticate_request, only: [:login], raise: false
  
    def login
      authenticate params[:username], params[:password]
    end
  
  
      private
      def authenticate(username, password)
        user = Admin.find_by(username: username)
        command = AuthenticateAdmin.call(username, password)
  
        if command.success?
          render json: {
            token: command.result,
            user: ActiveModelSerializers::SerializableResource.new(user)
          }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
       end
    end
  