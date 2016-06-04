class User < ActiveRecord::Base
  before_save :ensure_authentification_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def ensure_authentification_token
  	if auth_token.blank?
  		self.auth_token = generate_authentification_token
  	end
  end

  private

  	def generate_authentification_token
  	  loop do
  	  	token = Devise.friendly_token
  	  	break token unless User.where(auth_token: token).first
  	  end
  	end

  	def self.find_for_facebook_oauth(auth)
  	  where(provider: auth[:provider], fb_id: auth[:fb_id]).first_or_create do |user|
  	    user.email = auth[:email]
  	    user.password = Devise.friendly_token[0,20]
  	    user.last_name = auth[:last_name]
  	    user.first_name = auth[:first_name]
  	    user.date_birthday = auth[:date_birthday]
  	    user.sexe = auth[:sexe]
  	    user.fb_image_url = auth[:fb_image_url]
  	    user.fb_token = auth[:fb_token]
  	  end
    end
end
