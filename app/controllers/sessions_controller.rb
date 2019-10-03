class SessionsController < ApplicationController
  def index

  end

  def new

  end

  def create
    url = Rails.application.routes.recognize_path(request.referrer)   #fetch where the call is coming from
    last_controller = url[:controller]
#student logged in not librarian
    if last_controller == "students"
      @student = Student.find_by_email(log_params[:email])
      if !@student.nil?                                     #check if student exists
        if @student.authenticate(log_params[:password])     # if yes, please authenticate
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
              redirect_to students_index_path(@student) and return
            end
        else
        redirect_to students_login_url, alert: "Invalid ID or Password!!" and return
        end
      else
        redirect_to new_student_path, alert: "Student ID does not exists, Please register!" and return
      end
    end

#librarian logged in
    if last_controller == "librarians"
      @librarian = Librarian.find_by_email(log_params[:email])
      if !@librarian.nil?
        if @librarian.authenticate(log_params[:password])
          session[:id] = @librarian.id
          redirect_to librarians_index_path(@librarian) and return
        else
          redirect_to librarians_login_url, alert: "Invalid ID or Password!!" and return
        end
      else
        redirect_to new_librarian_path, alert: "Librarian ID does not exists, Please register!!" and return
      end
    end
#admin logged in
    if last_controller == "admins"
         @admin = Admin.find_by_email(log_params[:email])
         if !@admin.nil?
           if @admin.authenticate(log_params[:password])
              session[:id] = @admin.id
              redirect_to admins_index_path(@admin) and return
           else
              redirect_to admins_login_path, alert: "Invalid ID or Password!!" and return
           end
        else
          redirect_to admins_login_path, alert: "This Admin ID does not exists!!" and return
        end
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

