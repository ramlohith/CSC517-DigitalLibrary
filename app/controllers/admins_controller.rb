class AdminsController < ApplicationController
  def index

  end

  def new
    @admin = Admin.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
    end
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to login_index_url alert: "Registration Successful, Please login!!"
    else
      redirect_to new_student_url, alert: "OOPS!! Problem Occurred. Please enter details again!"
    end
  end

  def allstudents
    @students = Student.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  def allstaff
    @librarians = Librarian.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @librarians }
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @librarian = Librarian.find(params[:id])
    if @student != nil?
      @student.destroy
    elsif @librarian !=nil?
      @librarian.destroy
     end

    respond_to do |format|
      format.html { redirect_to admins_index_path }
      format.json { head :no_content }
    end
  end

  def books_on_hold
    @h_requests = HoldRequest.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @h_requests }
    end
  end

  def checked
    @checkbooks = HistoryRequest.where(status: "Checked Out")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkbooks }
    end
  end

  def borrow_history
  @borrowbooks = HistoryRequest.all.group(:isbn, :student_email)
  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @borrowbooks }
  end
  end

  def overdue
    @overdues = HistoryRequest.all.group(:isbn, :student_email)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @overdues }
    end
  end

  private
  def admin_params
    params.require(:admin).permit(:email, :name, :password)
  end
end
