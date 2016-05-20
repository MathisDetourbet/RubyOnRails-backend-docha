class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  respond_to :json
  skip_before_filter :verify_authenticity_token

  #POST /resource
  def create
    user = User.new(user_params)
    if user.save
      sign_in user
      render :json => { 
                :success => true,
                :info => "Registered",
                :data => { :user => user,
                           :auth_token => user.auth_token,
                           :sign_in => user_signed_in?
                         }
              },
           :status => 201
    else
      warden.custom_failure!
      render :json => { :success => false,
                        :info => user.errors,
                        :data => {} 
                      }, 
             :status => :unprocessable_entity
    end
  end

  def invalid_login_attempt
    render :json => { :success => false,
                      :message => "Invalid email or password"},
                      :status => 401
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update)<<[:date_birthday, :sexe, :avatar, :category_favorite]
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
