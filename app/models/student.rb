class Student < ApplicationRecord
  validates :email, uniqueness: true
end
