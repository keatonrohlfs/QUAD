# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
# end
  
User.find_or_create_by(username: 'admin') do |user|
    user.email = ENV['ADMIN_EMAIL']
    user.password = ENV['ADMIN_PASSWORD']
    user.phone_number = '1234567890'
    user.first_name = 'Marketplace'
    user.last_name = 'Admin'
    user.role = 'admin'
    user.confirmed_at = Time.now
end

user = User.find_or_create_by(username: 'user') do |user|
    user.email = 'user@crimson.ua.edu'
    user.password = 'password'
    user.phone_number = '1234567899'
    user.first_name = 'Demo'
    user.last_name = 'User'
    user.role = 'normal'
    user.confirmed_at = Time.now
end

Listing.find_or_create_by(title: 'Dress1') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end 
Listing.find_or_create_by(title: 'Dress2') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress3') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress4') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress5') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress6') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress7') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress8') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress9') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress10') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end 
Listing.find_or_create_by(title: 'Dress11') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress12') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress13') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress14') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress15') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress16') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress17') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
Listing.find_or_create_by(title: 'Dress18') do |listing|
    listing.category = 'Dresses'
    listing.size = '6'
    listing.original_price = 10
    listing.listing_price = 8
    listing.user =  user
    listing.sell = true
end
