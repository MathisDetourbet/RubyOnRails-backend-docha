class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!
  respond_to :json
  skip_before_filter :verify_authenticity_token

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @user = User.find(params[:id])
      if @user.update(user_params)
        format.json { render :json => { :success => true,
                          :info => "Profil updated",
                          :data => { :user => @user }
                        },
               :status => 200
             }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def get_user_friends_docha
    fb_access_token = params[:user][:fb_token]
    if fb_access_token.to_s != ''
      graph = Koala::Facebook::API.new(fb_access_token)

      friendsList = Array.new

      friends = graph.get_connections('me', 'invitable_friends', api_version: 'v2.7')#("me/friends?fields=picture.type(small)")
      friends.each do |friend|
        puts friend
        friendID = friend["id"]
        user = User.where(fb_id: friendID).first
        if user
          friendsList.push(user)
        end
        friendsList.push(friend)
      end

      #unless friendsList.empty?
        render :json => { 
                :success => true,
                :data => { :friends => friends }
              },
               :status => 201
        #else
          #render :json => { :success => false, :friends => friendsList, :info => "FriendsList is empty" }
      #end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
      :email, :password, :username, 
      :date_birthday, :sexe, :last_name, :first_name, :category_favorite, :avatar,
      :fb_token, :fb_image_url, :experience, :dochos, :perfects, :levelUser
      )
    end
end
