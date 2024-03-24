class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :settings, :destroy, :update]
    before_action :redirect_if_authenticated, only: [:create, :new]
    
    def create
        @user = User.new(create_user_params)
        if @user.save
            @user.send_confirmation_email!
            redirect_to login_path, alert: "Please check your email for confirmation instructions."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
      current_user.destroy
      reset_session
      redirect_to login_path, alert: "Your account has been deleted."
    end

    def profile
      @user = current_user
      @active_sessions = @user.active_sessions.order(created_at: :desc)
    end

    def settings
      @user = current_user
      @active_sessions = @user.active_sessions.order(created_at: :desc)
    end

    def new
      @user = User.new
    end

    def update
      @user = current_user
      @active_sessions = @user.active_sessions.order(created_at: :desc)
      if @user.authenticate(params[:user][:current_password])
        if @user.update(update_user_params)
          if params[:user][:unconfirmed_email].present?
            @user.send_confirmation_email!
            redirect_to root_path, notice: "Check your email for confirmation instructions."
          else
            redirect_to account_settings_path, notice: "Account updated."
          end
        else
          render :account_settings, status: :unprocessable_entity
        end
      else
        flash.now[:error] = "Incorrect password"
        render :account_settings, status: :unprocessable_entity
      end
    end

    private

    def create_user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :username, :password, :password_confirmation)
    end

    def update_user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
    end
end
