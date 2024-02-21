class UsersController < ApplicationController
    before_action :load_user_from_session, only: [:signup, :profilepic, :aboutyou]
  
    def create
      @user = User.new(session[:user_params])
      if @user.save
        session.delete(:user_params)
        redirect_to root_path, notice: "Signup complete! Please check your email for confirmation instructions."
      else
        render :aboutyou, status: :unprocessable_entity
      end
    end
  
    def signup
      session[:user_params] ||= {}
      @user = User.new
    end
  
    def profilepic
      session[:user_params].merge!(user_params)
      @user = User.new(session[:user_params])
      render :profilepic
    end
  
    def aboutyou
      session[:user_params].merge!(user_params)
      @user = User.new(session[:user_params])
      render :aboutyou
    end
  
    private
  
    def load_user_from_session
      @user = User.new(session[:user_params] || {})
    end
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_picture, :social_media, :graduation_year)
    end
  end

  
