# Check user login and reference the current user
class AuthenticationController < ApplicationController

    skip_before_action :authenticate_request
   
    # Takes in JSON params for email and password
    # and pass to authenticate user 
    # If successful, send JWT token to the user
    def authenticate
   
      command = AuthenticateUser.call(params[:email], params[:password])
   
   
      if command.success?
   
        render json: { auth_token: command.result }
   
      else
   
        render json: { error: command.errors }, status: :unauthorized
   
      end
   
    end
   
   end