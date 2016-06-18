class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]
respond_to :json
skip_before_filter :verify_authenticity_token

#POST /resource
def create
  user = User.new(user_params)
  if user.save
    #sign_in user
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

def auth_facebook
  fb_access_token = params[:user][:fb_token]
  if fb_access_token.to_s != ''
    graph = Koala::Facebook::API.new(fb_access_token)

    profile = graph.get_object("me?fields=id, email, birthday, gender, last_name, first_name, picture.type(large)")
    fb_profile_hash = Hash.new
    fb_profile_hash[:provider] = "facebook"
    fb_profile_hash[:fb_id] = profile["id"]
    fb_profile_hash[:fb_token] = fb_access_token
    fb_profile_hash[:email] = profile["email"]
    fb_profile_hash[:first_name] = profile["first_name"]
    fb_profile_hash[:last_name] = profile["last_name"]
    fb_profile_hash[:date_birthday] = profile["birthday"]
    if profile["gender"] == "male"
      fb_profile_hash[:sexe] = "M"
    else
      fb_profile_hash[:sexe] = "F"
    end
    fb_profile_hash[:fb_image_url] = profile["picture"]["data"]["url"]

    puts fb_profile_hash
    
    @user = User.find_for_facebook_oauth(fb_profile_hash)

    if @user.persisted?
      sign_in(@user)
      render :json => { 
              :success => true,
              :data => { :user => @user,
                         :sign_in => user_signed_in?
                       }
            },
             :status => 201
    else
      session["devise.facebook_profil"] = fb_profile_hash
      puts "Error authentication facebook : redirect to new registration"
    end
  else
  #Bad Access Token !
  render :json => { :success => false, 
                    :info => "Facebook access token is empty or nil"
                  }
  end
end

def invalid_login_attempt
  render :json => { :success => false,
                    :message => "Invalid email or password"},
                    :status => 401
end

private
  def user_params
    params.require(:user).permit(
      :email, :password, 
      :date_birthday, :sexe, :last_name, :first_name, :category_favorite, :avatar,
      :fb_token, :fb_image_url
    )
  end

# GET /resource/edit
# def edit
#   super
# end

# PUT /resource
def update
  user = User.find(current_user.id)
end

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
def configure_sign_up_params
  devise_parameter_sanitizer.permit(:sign_up, keys: [:date_birthday, :sexe, :avatar, :category_favorite, :username])
end

# If you have extra params to permit, append them to the sanitizer.
def configure_account_update_params
  devise_parameter_sanitizer.for(:account_update)<<[:date_birthday, :sexe, :avatar, :category_favorite, :username, :auth_token]
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
