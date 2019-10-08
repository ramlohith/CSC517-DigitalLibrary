class Student < ApplicationRecord
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true, presence: true
    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 6 }
    validates :university, presence: true
    has_secure_password
end
