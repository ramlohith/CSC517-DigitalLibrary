class SessionsController < ApplicationController
  def index

  end
  def new

  end

  def create

    @student = Student.find_by_email(log_params[:email])
    @librarian = Librarian.find_by_email(log_params[:email])
    @admin = Admin.find_by_email(log_params[:email])
#student logged in not librarian
    if !@student.nil? && @librarian.nil?
      if @student.authenticate(log_params[:password])
      session[:id] = @student.id
      totalfine = 0
      @bookmark = Bookmark.where(student_email: @student.email)
      @history_request = HistoryRequest.where(student_email: @student.email)
        if !@history_request.nil?
            @history_request.each do |hist|
            @book = Book.where(isbn: hist.isbn).first
            @library = Library.where(university: @book.university, name: @book.library).first
            hist = hist.calculatefines(@library.maxdays, @library.fine)
            totalfine = totalfine + hist.fines
            hist.save
                                  end
            @history_request_totalfines = HistoryRequest.new(:fines => totalfine)
            @history_request = HistoryRequest.where("fines > 0", student_email: @student.email)
            render 'students/index' and return
        end
      else
        redirect_to students_login_url, alert: "Invalid ID or Password!!" and return
      end
    end

#librarian logged in
    if !@librarian.nil? && @student.nil?
      if @librarian.authenticate(log_params[:password])
        session[:id] = @librarian.id
        render 'librarians/index' and return
      else
        redirect_to librarians_login_url, alert: "Invalid ID or Password!!" and return
      end
    end
#admin logged in
    if !@admin.nil? && @admin.authenticate(log_params[:password])
      session[:id] = @admin.id
      render 'admins/index' and return
    else
      redirect_to admins_login_path, alert: "Invalid ID or Password!!" and return
    end
# email not registered as student, librarian, admin
    if @librarian.nil? && @student.nil? && @admin.nil?
      redirect_to login_index_url, alert: "No records found, Please Register!"
    end

  end

  def log_params
    params.require(:sessions).permit(:email, :password )
  end

  def destroy
    reset_session
    if !@self.nil?
      @self = nil
    end
    redirect_to login_index_url, alert: "Successfully logged out"
  end

end

