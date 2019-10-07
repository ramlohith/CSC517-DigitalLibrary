class HistoryRequest < ApplicationRecord

  def evaluatebooks(isbn)
      totalfine = 0
      @book = Book.where(isbn: isbn).first
      @library = Library.where(university: @book.university, name: @book.library).first
      hist = self.calculatefines(@library.maxdays, @library.fine)
      totalfine = totalfine + hist.fines
      hist.save
    totalfine
  end

  def calculatefines(maxdays,fine)
   if (Time.now - self.updated_at)/86400 > 1

    if self.status == "Checked Out"
     daysdiff = (Time.now - self.updated_at) / 86400

      if daysdiff > maxdays
        self.fines = self.fines + fine
      end
   end
   end
   self
  end

  def checkoutavailability(email,maxbooks)
    HistoryRequest.where(student_email:email, status:'Checked Out').count > maxbooks
  end
end