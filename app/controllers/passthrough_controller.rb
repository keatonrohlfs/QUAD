class PassthroughController < ApplicationController
  def index
    if current_user
    @user = current_user
      if @user.role ="admin"
        redirect_to account_admin_path
      else @user.role = "normal"
        redirect_to account_admin_path
      end
    else
      redirect_to login_path
    end
  end
end