class ListingsController < ApplicationController
  before_action :require_login

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  def clear_flash
    flash.discard # Or flash.clear to remove all flash values
    redirect_back(fallback_location: root_path)
  end

  def index
    if params[:search].present?
  # Join the users table and search for first_name in the users table
      @listings = Listing.joins(:user).where('users.first_name ILIKE ?', "%#{params[:search]}%")
    else
      @listings = Listing.all
  end
end
  
  # POST /listings
  def create
    @listing = current_user.listings.build(listing_params)
    @listing.sell = @listing.listing_price
    @listing.rent = @listing.rental_price
    if @listing.save
      redirect_to @listing, notice: 'Listing was successfully created.'
    else
      render :new
    end
  end

  # GET /listings/:id
  def show
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.status = "Verified"
    if @listing.save
      redirect_to account_admin_path, notice: 'Listing was successfully verified.'
    else
      redirect_to account_admin_path, notice: 'Listing was not able to be verified.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(
      :title, :category, :size, :brand, :color, :status,
      :new_with_tags, :sell, :rent, :original_price, 
      :listing_price, :rental_price, style_tags: [], photos: []
    )
  end
end