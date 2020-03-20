class App::AuthController < ApplicationController
  skip_before_action :authenticate_request

    def login
      authenticate params[:username], params[:password]
    end

    def signup
      @user = User.create!(
        username: params[:username],
        password: params[:username],
        activation_code: rand(9999999).to_s.center(6, rand(9).to_s)
      )
      render json: @user
    end

    def activate
      @user = User.find_by(username: params[:username])
      if @user.activation_code == params["activation_code"]
        render json: @user
      else
        render json: { error: "no user" }, status: 422
      end
    end

    def set_password
      @user = User.find_by(username: params[:username])
      @user.password = params[:password]

      if @user.save!
        render json: @user
      else
        render json: { error: "no user" }, status: 422
      end
    end


    private
    def authenticate(username, password)
      user = User.find_by(username: username)
      command = AuthenticateUser.call(username, password)

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
