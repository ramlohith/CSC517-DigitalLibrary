class Student < ApplicationRecord

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true, presence: true
    validates :name, presence: true
    validates :password, presence: true
    validates :university, presence: true

end
