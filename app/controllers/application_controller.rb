class ApplicationController < ActionController::Base
    include Authentication

    ShopifyAPI::Context.setup(
      api_key: ENV['SHOPIFY_API_KEY'],
      api_secret_key: ENV['SHOPIFY_API_SECRET'],
      api_version: ENV['SHOPIFY_API_VERSION'],
      scope: [
        'read_customers',
        'write_customers',
        'read_fulfillments',
        'write_fulfillments',
        'read_inventory',
        'write_inventory',
        'write_order_edits',
        'read_order_edits',
        'write_orders',
        'read_orders',
        'write_products',
        'read_products',
      ],
      is_embedded: false,
      is_private: true
    )

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
