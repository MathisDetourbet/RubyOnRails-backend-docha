class Users::FacebookController < ApplicationController
  respond_to :json

  def create
  	fb_access_token = user[:fb_access_token]
  	unless fb_access_token.blank? || fb_access_token.nil?
  	  graph = Koala::Facebook::API.new(fb_access_token)

  	  @profile = graph.get_object("me")
  	  friends = @graph.get_connections("me", "friends")

  	  puts profile

  	end

  	#Bad Access Token !
  end


  private
    def user_params
      params.require(:user).permit(:fb_access_token)
  	end
end
