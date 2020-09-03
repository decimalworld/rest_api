class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :generate_authentication_token!, on: :create
  validates :auth_token, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
