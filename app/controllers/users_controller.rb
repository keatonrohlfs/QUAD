
class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        @user.send_confirmation_email!
        redirect_to root_path, notice: "Please check your email for confirmation instructions."
      else
        render :signup, status: :unprocessable_entity
      end
    end

    def signup
    @user = User.new
    end

    def profilepic 
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :username, :password, :password_confirmation)
    end

end
