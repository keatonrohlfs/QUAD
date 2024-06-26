class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:profile_admin, :profile_normal, :settings, :destroy, :update]
    before_action :redirect_if_authenticated, only: [:create, :new]
    before_action :verify_admin, only: [:profile_admin]

    def create
        @user = User.new(create_user_params)
        if @user.save
            @user.send_confirmation_email!
            redirect_to login_path, flash: { notice: "Please check your email for confirmation instructions." }
        else
            render :new, status: :unprocessable_entity
        end
    end

    def clear_flash
      flash.discard # Or flash.clear to remove all flash values
      redirect_back(fallback_location: root_path)
    end

    def destroy
      current_user.destroy
      reset_session
      redirect_to login_path, alert: "Your account has been deleted."
    end

    def profile_normal
      @user = current_user
      @listings = @user.listings || []

      if params[:unverified_only] == '1'
        @listings = @listings.where(status: 'Unverified')
      end

      if params[:sort_by].present?
        sort_column, sort_direction = params[:sort_by].split('_')
        sort_column = case sort_column
                      when 'title'
                        'title'
                      when 'listingprice'
                        'listing_price'
                      when 'createdat'
                        'created_at'
                      else
                        'created_at'
                      end

        sort_direction = sort_direction == 'asc' ? 'asc' : 'desc'

        @listings = @listings.order("#{sort_column} #{sort_direction}")
      else
        @listings = @listings.order(created_at: :desc)
      end

      # @listings = @user.listings.order(sort_column => sort_direction) || []
      @active_sessions = @user.active_sessions.order(created_at: :desc)
    end

    def profile_admin
      @user = current_user
      @listings = Listing.all

      if params[:unverified_only] == '1'
        @listings = @listings.where(status: 'Unverified')
      end

      if params[:user_search].present?
        search_query = params[:user_search].strip
        first_name, last_name = search_query.split(' ')

        if first_name.present? && last_name.present?
          @listings = @listings.joins(:user).where("users.first_name ILIKE :first_name AND users.last_name ILIKE :last_name", first_name: "%#{first_name}%", last_name: "%#{last_name}%")
        elsif first_name.present?
          @listings = @listings.joins(:user).where("users.first_name ILIKE :search", search: "%#{first_name}%")
        elsif last_name.present?
          @listings = @listings.joins(:user).where("users.last_name ILIKE :search", search: "%#{last_name}%")
        end
      end

      if params[:sort_by].present?
        sort_column, sort_direction = params[:sort_by].split('_')
        sort_column = case sort_column
                      when 'title'
                        'title'
                      when 'listingprice'
                        'listing_price'
                      when 'createdat'
                        'created_at'
                      else
                        'created_at'
                      end

        sort_direction = sort_direction == 'asc' ? 'asc' : 'desc'

        @listings = @listings.order("#{sort_column} #{sort_direction}")
      else
        @listings = @listings.order(created_at: :desc)
      end

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

    def verify_admin
      @user = current_user
      if @user.admin?
      else
        redirect_to account_user_path, notice: 'Cannot perform action: not authorized'
      end
    end

    def create_user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :admin)
    end

    def sort_column
      %w[title listing_price created_at].include?(params[:sort]) ? params[:sort] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    end
end
