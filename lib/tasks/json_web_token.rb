
class JsonWebToken

    class << self
     # Create a unique token by encoding user ID, 
     # the expiration day and the unique base key 
      def encode(payload, exp = 24.hours.from_now)
   
        payload[:exp] = exp.to_i
   
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
   
      end
   
      # Decode takes the token and uses key to decode it
      def decode(token)
   
        body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
   
        HashWithIndifferentAccess.new body
   
      rescue
   
        nil
   
      end
   
    end
   
   end