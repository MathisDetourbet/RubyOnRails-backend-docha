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
end
