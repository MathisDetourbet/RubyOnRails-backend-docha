class Users::SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]
    respond_to :json

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      user = User.find_by_email(params[:email])
      return invalid_login_attempt unless user

      if user.valid_password?(params[:password])
        sign_in(user)
        user.ensure_authentification_token
        render :json => { :success => true,
                          :info => "Sign in",
                          :data => { :user => user,
                                   :auth_token => user.auth_token,
                                   :sign_in => user_signed_in?
                                   }
                        },
               :status => 200
        return
      end
      invalid_login_attempt
    end

    def signup_with_facebook
   	  puts "METHOD signup_with_facebook !!!!!"
    end

    # DELETE /resource/sign_out
    def destroy
        sign_out(current_user) if user_signed_in?
    end

    protected

      def ensure_params_exist
        return unless params[:email].blank?
        render :json => { :success => false,
                          :message => "Missing user_login parameters",
                          :status => 401 
                        }
      end

      def invalid_login_attempt
        warden.custom_failure!
        render :json => { :success =>false,
                          :message =>"Invalid email or password" 
                        }, 
               :status => 401
      end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
end
