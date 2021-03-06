class ApplicationController < ActionController::Base
  # Comes before Devise's one
  before_filter :authentificate_user_from_token!
  # Devise auth
  before_filter :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

  	def authentificate_user_from_token!
  	  user_email = params[:email].presence
  	  user = user_email && User.find_by_email(user_email)
    	
      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.
      if user && Devise.secure_compare(user.auth_token, params[:auth_token])
     	  sign_in user, store: false
      end
    end
end
