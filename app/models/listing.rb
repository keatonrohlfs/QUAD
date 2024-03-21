class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :photos  # Ensure this matches the form and your ActiveStorage setup

  # Validate presence of required fields as per your form and database constraints
  validates :title, presence: true
  validates :category, presence: true
  validates :size, presence: true

  # Since you have 'sell' and 'rent' as boolean fields in your database,
  # you don't necessarily need to validate their presence because booleans are
  # false by default, which is a valid state. However, you might want to ensure
  # at least one of them is true if that's a business requirement.
  validate :sell_or_rent_present

  # Validate listing_price if 'sell' is true
  validates :listing_price, presence: true, if: -> { sell? }

  # Validate rental_price if 'rent' is true
  validates :rental_price, presence: true, if: -> { rent? }

  # You might also want to validate that the prices are numerical and greater than or equal to 0
  validates :original_price, :listing_price, :rental_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Validate style_tags as an array. Ensure it's an array and each element is a string.
  validate :style_tags_are_valid

  private

  def sell_or_rent_present
    errors.add(:base, 'Must be available for sell or rent.') unless sell? || rent?
  end

  def style_tags_are_valid
    if style_tags.present?
      unless style_tags.is_a?(Array) && style_tags.all? { |tag| tag.is_a?(String) }
        errors.add(:style_tags, 'must be an array of strings')
      end
    end
  end
end
