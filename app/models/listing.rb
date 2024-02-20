class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures

  validates :title, :category, :size, :listing_price, presence: true
  # Add any other validations you require
end
