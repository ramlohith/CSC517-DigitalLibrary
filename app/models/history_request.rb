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
    HistoryRequest.where(student_email:email, status:'Checked Out').count >= maxbooks
  end

  def setreturn
    self.status = "Returned"
    var_isb = self.isbn
    book_obj = Book.where(isbn:var_isb).first
    book_obj.number_available = book_obj.number_available + 1
    book_obj.number_checkedout= book_obj.number_checkedout - 1
    book_obj.save
    holdreq_obj = HoldRequest.where(isbn: book_obj.isbn).first
    if !holdreq_obj.nil?
      if !book_obj.special
        obj = HistoryRequest.where(isbn: book_obj.isbn, student_email: holdreq_obj.student_email ).first
        obj.status = "Checked Out"
        book_obj.number_available = book_obj.number_available - 1
        book_obj.number_checkedout = book_obj.number_checkedout + 1
        obj.save
      elsif book_obj.special
        obj = HistoryRequest.where(isbn: book_obj.isbn, student_email: holdreq_obj.student_email ).first
        obj.status = "Waiting for Approval"
        book_obj.number_available = book_obj.number_available - 1
        book_obj.number_checkedout = book_obj.number_checkedout + 1
        apprvl = ApprovalRequest.new(:student_email => holdreq_obj.student_email, :isbn => book_obj.isbn, :title => book_obj.title, :author => book_obj.author, :edition => book_obj.edition, :university => book_obj.university)
        obj.save
        apprvl.save
      end
      holdreq_obj.delete
      book_obj.number_holdrequest = book_obj.number_holdrequest - 1
      book_obj.save
    end

    self
  end
end