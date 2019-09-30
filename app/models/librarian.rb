class Librarian < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, presence: true
  validates :library, presence: true
  has_secure_password validations: false
end
