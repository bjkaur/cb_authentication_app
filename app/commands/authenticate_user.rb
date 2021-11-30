class AuthenticateUser

    prepend SimpleCommand
  
    # Initialize a class instance with email and password
    def initialize(email, password)
  
      @email = email
  
      @password = password
  
    end
  
  
    def call
  
      JsonWebToken.encode(user_id: user.id) if user
  
    end
  
  
    private
  
  
    attr_accessor :email, :password
  
    # Check if user exists in db
    # If User exists, use built in authenticate to return the use
    # else return nil
    def user
  
      user = User.find_by_email(email)
  
      return user if user && user.authenticate(password)
  
  
      errors.add :user_authentication, 'invalid credentials'
  
      nil
  
    end
  
  end