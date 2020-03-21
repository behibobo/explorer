class AuthenticateAdmin
    prepend SimpleCommand
    attr_accessor :username, :password
  
    #this is where parameters are taken when the command is called
    def initialize(username, password)
      @username = username
      @password = password
    end
    
    #this is where the result gets returned
    def call
      JsonWebToken.encode(admin_id: admin.id) if admin
    end
  
    private
  
    def admin
      admin = Admin.find_by_username(username)
      return admin if admin && admin.authenticate(password)
  
      errors.add :admin_authentication, 'Invalid credentials'
      nil
    end
  end