class Book < ApplicationRecord
  validates :isbn, uniqueness: true
end
