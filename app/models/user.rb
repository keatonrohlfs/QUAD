class User < ApplicationRecord
    has_secure_password
  
    validates :username, :email, :phone_number, :first_name, :last_name, :social_media, :profile_picture, presence: true
    validates :username, :email, uniqueness: true
  end
  