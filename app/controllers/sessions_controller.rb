class SessionsController < ApplicationController
  def index

  end
  def new

  end

  def create

    @student = Student.find_by_email(log_params[:email])
    @librarian = Librarian.find_by_email(log_params[:email])

    if @student.nil? && @librarian != nil?
      if @librarian && @librarian.authenticate(log_params[:password])
        session[:id] = @librarian.id
        render 'librarian/index', alert: "Logged In!!"
      else
        redirect_to librarian_login_url, alert: "Invalid ID or Password!!"
      end
    end

    if @student != nil? && @librarian.nil?
      if @student && @student.authenticate(log_params[:password])
        session[:id] = @student.id
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

