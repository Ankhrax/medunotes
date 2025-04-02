class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :notes, dependent: :destroy

  normalizes :email_address, with: ->(e) { e&.strip&.downcase }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: :invalid_email
  }

  validates :password, presence: true, length: { minimum: 8 }, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}\z/,
    message: :weak_password
  }, confirmation: true
end
