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
    user.email = 'admin@crimson.ua.edu'
    user.password = 'password'
    user.phone_number = '1234567890'
    user.first_name = 'Quad Marketplace'
    user.last_name = 'Admin'
    user.role = 'admin'
    user.confirmed_at = Time.now
end
  
