class SessionsController < ApplicationController
  def index

  end
  def new

  end

  def create

    @student = Student.find_by_email(log_params[:email])
    @librarian = Librarian.find_by_email(log_params[:email])
    @admin = Admin.find_by_email(log_params[:email])


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
        redirect_to 'librarian/index', alert: "Logged In!!"
      else
        redirect_to librarian_login_url, alert: "Invalid ID or Password!!"
      end
    end

    if @student != nil? && @librarian.nil? && @admin.nil?
      if @student && @student.authenticate(log_params[:password])
        session[:id] = @student.id
        redirect_to students_index_path(@student) and return
      else
        redirect_to students_login_url, alert: "Invalid ID or Password!!"
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

