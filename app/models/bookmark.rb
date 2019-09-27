class Bookmark < ApplicationRecord
  validates :isbn, uniqueness: true
end
