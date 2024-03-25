class PassthroughController < ApplicationController
  def index
    @user = current_user
      if @user.admin?
        redirect_to account_admin_path
      end
      if !@user.admin?
        redirect_to account_normal_path
      end
    end 
end