class Bookmark < ApplicationRecord
  validates :isbn, uniqueness: {scope: [:isbn, :student_email]}
  def createnewbookmark(books_id,student_email, student_name)
    book = Book.find(books_id)
    obj = Bookmark.new(:isbn => book.isbn , :title => book.title, :author => book.author, :edition => book.edition, :student_name => student_name, :student_email => student_email)
    obj.save
  end
end
