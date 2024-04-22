class PassthroughController < ApplicationController
  def index
    if current_user
    @user = current_user
      if @user.admin?
        redirect_to account_admin_path
      elsif @user.normal?
        redirect_to account_user_path
      end
    else
      redirect_to login_path
    end
  end
end
