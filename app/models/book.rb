class Book < ApplicationRecord

  validates :isbn, uniqueness: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  #validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates :title , presence: true
  validates :author, presence: true
  validates :language, presence: true
  validates :published, presence: true
  validates :edition, presence: true
 # validates :image, presence: true
  validates :subject, presence: true
  validates :summary, presence: true
  validates :number_available, presence: true
end
