class App::AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :activate], raise: false

    def login
      user = User.where(mobile: params[:mobile]).first_or_initialize
      user.activation_code = rand(9999).to_s.center(4, rand(9).to_s)
      user.save

      render json: user.to_json
    end

    def activate
      authenticate params[:mobile], params[:activation_code]
    end


    private
    def authenticate(mobile, activation_code)
      user = User.find_by(mobile: mobile)
      command = AuthenticateUser.call(mobile, activation_code)

      if command.success?
        render json: {
          token: command.result,
          user: user
        }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
     end
  end
