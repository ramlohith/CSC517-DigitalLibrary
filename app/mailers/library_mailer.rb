class LibraryMailer < ApplicationMailer
  default from: "digitallibrary.csc517@gmail.com"

  def library_mailer(student)
    @student = student
    mail(to: @student.email, subject: 'You have recently checkout a book!')
  end
end
