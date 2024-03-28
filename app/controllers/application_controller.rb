class ApplicationController < ActionController::Base
    include Authentication

    def clear_flash
      flash.discard # Or flash.clear to remove all flash values
      redirect_back(fallback_location: root_path)
    end

    private
      def require_login
        unless current_user
          redirect_to login_path
        end
      end
end
