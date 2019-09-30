class SessionsController < ApplicationController
  def index

  end
  def new

  end

  def create

    @student = Student.find_by_email(log_params[:email])
    @librarian = Librarian.find_by_email(log_params[:email])

    if @student.nil? && @librarian != nil?
      if @librarian && @librarian.authenticate(params[:password])
      #if (@librarian.password == log_params[:password]) && (@librarian.email == log_params[:email])
        session[:id] = @librarian.id
        render 'librarian/index', alert: "Logged In!!"
      else
        redirect_to librarian_login_url, alert: "Invalid ID or Password!!"
      end
    end

    if @student != nil? && @librarian.nil?
      if @student.authenticate(log_params[:password])
        #if (@student.password == log_params[:password]) && (@student.email == log_params[:email])
        session[:id] = @student.id
        totalfine = 0
        @bookmark = Bookmark.where(student_email: @student.email)
        @history_request = HistoryRequest.where(student_email: @student.email)
        @history_request.each do |hist|
          @book = Book.where(isbn: hist.isbn).first
          @library = Library.where(university: @book.university, name: @book.library).first
          hist = hist.calculatefines(@library.maxdays, @library.fine)
          totalfine = totalfine + hist.fines
          hist.save
        end
        @history_request_totalfines = HistoryRequest.new(:fines => totalfine)
        @history_request = HistoryRequest.where("fines > 0", student_email: @student.email)
        render 'students/index'
      else
        redirect_to students_login_url, alert: "Invalid ID or Password!!"
      end
    end

    if @librarian.nil? && @student.nil?
      redirect_to login_index_url, alert: "No records found, Please Register!"
    end
  end

  def log_params
    params.require(:sessions).permit(:email, :password )
  end

  def destroy
    reset_session
    @student = nil
    redirect_to login_index_url, alert: "Successfully logged out"
  end

end

