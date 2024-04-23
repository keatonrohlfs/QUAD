class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  # Validate presence of required fields as per your form and database constraints
  validates :title, presence: true
  validates :category, presence: true
  validates :size, presence: true
  validates :photos, presence: true, comparison: { greater_than: 2}

  # Validate numericality for prices but allow nil for flexibility in custom validation
  validates :original_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :listing_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :rental_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Custom validation methods
  validate :price_based_on_sell_or_rent_option

  private

  # Validation: Listing price is required if selling, Rental price is required if renting
  def price_based_on_sell_or_rent_option
    if sell && !rent && listing_price.blank?
      errors.add(:listing_price, "can't be blank if item is for sell")
    end

    if rent && !sell && rental_price.blank?
      errors.add(:rental_price, "can't be blank if item is for rent")
    end

    if sell && rent && (listing_price.blank? || rental_price.blank?)
      errors.add(:base, "Both Listing and Rental prices can't be blank if item is for sell and rent")
    end
  end

  def style_tags_are_valid
    if style_tags.present?
      unless style_tags.is_a?(Array) && style_tags.all? { |tag| tag.is_a?(String) }
        errors.add(:style_tags, 'must be an array of strings')
      end
    end
  end
end
