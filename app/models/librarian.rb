class Librarian < ApplicationRecord
  has_one :library
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true, presence: true
  validates :name, presence: true
  validates :password, presence: true
end
