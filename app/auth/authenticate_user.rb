# app/auth/authenticate_user.rb
class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :mobile, :activation_code

  #this is where parameters are taken when the command is called
  def initialize(mobile, activation_code)
    @mobile = mobile
    @activation_code = activation_code
  end
  
  #this is where the result gets returned
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by_mobile(mobile)
    return user if user && user.activation_code == activation_code

    errors.add :user_authentication, 'Invalid credentials'
    nil
  end
end