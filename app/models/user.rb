class User < ApplicationRecord
    

  CONFIRMATION_TOKEN_EXPIRATION = 10.minutes
  PASSWORD_RESET_TOKEN_EXPIRATION = 10.minutes
  MAILER_FROM_EMAIL = "no-reply@example.com"
  attr_accessor :current_password
  

  has_secure_password
  

  before_save :downcase_fields
  before_save :downcase_unconfirmed_email

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@crimson\.ua\.edu\z/, message: "must be a crimson.ua.edu account" }, presence: true, uniqueness: true
  validates :username, :phone_number, presence: true, uniqueness: true
  validates:first_name, :last_name, presence: true
  validates :unconfirmed_email, format: {with: URI::MailTo::EMAIL_REGEXP, allow_blank: true}

  def confirm!
    if unconfirmed_or_reconfirming?
      if unconfirmed_email.present?
        return false unless update(email: unconfirmed_email, unconfirmed_email: nil)
      end
      update_columns(confirmed_at: Time.current)
    else
      false
    end
  end

  def confirmable_email
    if unconfirmed_email.present?
      unconfirmed_email
    else
      email
    end
  end

  def confirmed?
    confirmed_at.present?
  end

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
  end
  def generate_password_reset_token
    signed_id expires_in: PASSWORD_RESET_TOKEN_EXPIRATION, purpose: :reset_password
  end

  def unconfirmed?
    !confirmed?
  end

  def send_confirmation_email!
    confirmation_token = generate_confirmation_token
    UserMailer.confirmation(self, confirmation_token).deliver_now
  end
  def send_password_reset_email!
    password_reset_token = generate_password_reset_token
    UserMailer.password_reset(self, password_reset_token).deliver_now
  end
  def reconfirming?
    unconfirmed_email.present?
  end

  def unconfirmed_or_reconfirming?
    unconfirmed? || reconfirming?
  end
end

  private

    def downcase_fields
      self.email = email.downcase
      self.first_name = first_name.downcase
      self.last_name = last_name.downcase
      self.username = username.downcase
    end
    def downcase_unconfirmed_email
      return if unconfirmed_email.nil?
      self.unconfirmed_email = unconfirmed_email.downcase
    end
  end
  