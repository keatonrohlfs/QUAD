class ApplicationController < ActionController::Base
    include Authentication

    private
      def require_login
        unless current_user
          redirect_to login_path
        end
      end
end
