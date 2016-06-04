module FacebookHelper
  def auth_facebook
	  fb_access_token = params[:user][:fb_access_token]
	  if fb_access_token.to_s != ''
	    graph = Koala::Facebook::API.new(fb_access_token)

	    profile = graph.get_object("me?fields=id,email, name, birthday, gender, last_name, first_name")
	    fb_id = profile["id"]
	    puts profile
	    
	    @user = User.find_by_fb_id(fb_id) 
	    if @user
	      sign_in(@user)
	    else
	      puts "DANS LE ELSE"
	      redirect_to sessions_controller_signup_with_facebook_url
	    end

	    render :json => { :success => true,
	                      :data => profile
	                    }
	  else
	  #Bad Access Token !
	  render :json => { :success => false, 
	                    :info => "Facebook access token is empty or nil"
	                  }
	  end
  end
end
