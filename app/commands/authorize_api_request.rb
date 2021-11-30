# Take request header and decode the token using
# JWT decode method
class AuthorizeApiRequest

    prepend SimpleCommand
  
  
    def initialize(headers = {})
  
      @headers = headers
  
    end
  
  
    def call
  
      user
  
    end
  
  
    private
  
  
    attr_reader :headers
  
    # If User is not found return nil 
    # or decoded auth token false
    def user
  
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  
      @user || errors.add(:token, 'Invalid token') && nil
  
    end
  
    # decode the code from http_auth_header 
    # and gets user id
    def decoded_auth_token
  
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  
    end
  
    # Get token from authorisation header 
    # received in initialisation method
    def http_auth_header
  
      if headers['Authorization'].present?
  
        return headers['Authorization'].split(' ').last
  
      else
  
        errors.add(:token, 'Missing token')
  
      end
  
      nil
  
    end
  
  end