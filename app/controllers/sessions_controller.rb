class SessionsController < ApplicationController
  def index

  end
  def new

  end

  def create

    @student = Student.find_by_email(log_params[:email])
    @librarian = Librarian.find_by_email(log_params[:email])
    @admin = Admin.find_by_email(log_params[:email])


    if @student.nil? && @librarian != nil?
      if @librarian.authenticate(log_params[:password])
      #if (@librarian.password == log_params[:password]) && (@librarian.email == log_params[:email])
    if @admin != nil? && @librarian.nil? && @student.nil?
      if @admin && @admin.authenticate(log_params[:password])
        session[:id] = @admin.id
        redirect_to admins_index_path(@admin) and return
      else
        redirect_to admins_login_path, alert: "Invalid ID or Password!!" and return
      end
    end

    if @librarian != nil? && @student.nil? && @admin.nil?
      if @librarian && @librarian.authenticate(log_params[:password])
        session[:id] = @librarian.id
        render 'librarians/index', alert: "Logged In!!"
      else
        redirect_to librarians_login_url, alert: "Invalid ID or Password!!"
      end
    end

    if @student != nil? && @librarian.nil?
      if @student.authenticate(log_params[:password])
        #if (@student.password == log_params[:password]) && (@student.email == log_params[:email])
    if @student != nil? && @librarian.nil? && @admin.nil?
      if @student && @student.authenticate(log_params[:password])
        session[:id] = @student.id
        redirect_to students_index_path(@student) and return
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
      end
    end
    end
    if @librarian.nil? && @student.nil? && @admin.nil?
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
        end

