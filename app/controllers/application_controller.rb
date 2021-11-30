# Use the JWT token for the current user
# Have current user available in all controllers
class ApplicationController < ActionController::API
    # header request passed by server to AuthoriseApiRequest
    # when user sends a request
    before_action :authenticate_request

    attr_reader :current_user
  
  
    private
  
    # Call result on AuthoriseApiRequest 
    # The result request returned to the current user
    def authenticate_request
  
      @current_user = AuthorizeApiRequest.call(request.headers).result
  
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  
    end
end
