class User < ApplicationRecord
    

  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes
  MAILER_FROM_EMAIL = "no-reply@example.com"

  has_secure_password

  before_save :downcase_fields

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@crimson\.ua\.edu\z/, message: "must be a crimson.ua.edu account" }, presence: true, uniqueness: true
  validates :username, :phone_number, presence: true, uniqueness: true
  validates:first_name, :last_name, presence: true

  def confirm!
    update_columns(confirmed_at: Time.current)
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end

  def unconfirmed?
    !confirmed?
  end

  def send_confirmation_email!
    confirmation_token = generate_confirmation_token
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end

  private

  def downcase_fields
    self.email = email.downcase
    self.first_name = first_name.downcase
    self.last_name = last_name.downcase
    self.username = username.downcase
  end


end
  