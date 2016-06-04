class Users::FacebookCallbacksController
  respond_to :json

  def facebook
  	fb_access_token = params[:fb_access_token]
  	unless fb_access_token.blank? || fb_access_token.nil?
  	  graph = Koala::Facebook::API.new(fb_access_token)

  	  @profile = graph.get_object("me")
  	  friends = @graph.get_connections("me", "friends")

  	  puts profile

  	end

  	#Bad Access Token !
  end
end