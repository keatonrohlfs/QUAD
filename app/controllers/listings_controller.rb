class ListingsController < ApplicationController
    before_action :require_login

    # GET /listings/new
    def new
      @listing = Listing.new
    end
  
    # POST /listings
    def create
      @listing = current_user.listings.build(listing_params)
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
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(
        :title, :category, :size, :brand, :color, 
        :new_with_tags, :sell, :rent, :original_price, 
        :listing_price, :rental_price, style_tags: [], photos: []
      )
    end
  end
  