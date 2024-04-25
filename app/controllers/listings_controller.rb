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
    session = ShopifyAPI::Auth::Session.new(
      shop: ENV['SHOPIFY_STORE_DOMAIN'],
      access_token: ENV['SHOPIFY_ACCESS_TOKEN']
    )
    @listing = Listing.find(params[:id])
    @listing.status = "Verified"
    if @listing.save
      body = {
        product: {
          title: @listing.title,
          body_html: generate_description_html(@listing),
          vendor: @listing.brand,
          product_type: @listing.category,
          status: 'active',
          images: @listing.photos.map { |photo| { src: photo.url } },
          variants: prepare_variants,
          tags: @listing.style_tags.join(', ')
        }
      }

      client = ShopifyAPI::Clients::Rest::Admin.new(
        session: session
      )
      response = client.post(
        path: "products",
        body: body
      )
      if response
        redirect_to account_admin_path, notice: 'Listing was successfully verified and uploaded to Shopify.'
      else
        redirect_to account_admin_path, alert: 'Listing was verified, but failed to upload to Shopify.'
      end
    else
      redirect_to account_admin_path, alert: 'Listing was not able to be verified.'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    if @listing.destroy
      redirect_to account_admin_path, notice: 'Listing was removed.'
    else
      redirect_to account_admin_path, notice: 'Listing was not able to be removed.'
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
      :listing_price, :style, :rental_price, style_tags: [], photos: []
    )
  end

  def prepare_variants
    variants = []
    variants << {
      option1: @listing.size,
      option2: @listing.color,
      option3: 'Buy',
      price: @listing.listing_price.to_s
    } if @listing.sell

    variants << {
      option1: @listing.size,
      option2: @listing.color,
      option3: 'Rent',
      price: @listing.rental_price.to_s
    } if @listing.rent

    variants
  end

  def generate_description_html(listing)
    "<p><strong>Title:</strong> #{listing.title}</p>" +
    "<p><strong>Size:</strong> #{listing.size}</p>" +
    "<p><strong>Color:</strong> #{listing.color}</p>"
  end

end
