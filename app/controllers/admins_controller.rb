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

  def users
    @students = Student.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end

    @librarians = Librarian.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @librarians }
    end
  end
def edit
  @admin = Admin.find(params[:id])
end

  def update
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update(email: params[:admin][:email],name: params[:admin][:name],password: params[:admin][:password])
        format.html { redirect_to admins_index_url, alert: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action:"edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    studentid = params[:student_id]
    libid = params[:lib_id]
    if !studentid.nil?
      @student = Student.find(studentid)
      @student.destroy
      respond_to do |format|
        format.html { redirect_to admins_users_path, alert: "Student Deleted!" }
        format.json { head :no_content }
      end
    elsif !libid.nil?
      @librarian = Librarian.find(libid)
      @librarian.destroy
      respond_to do |format|
        format.html { redirect_to admins_users_path, alert: "Librarian Deleted!" }
        format.json { head :no_content }
      end
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
    bookisbn = params[:book_isbn]
    if !bookisbn.nil?
      @borrowbooks = HistoryRequest.where(isbn: bookisbn)
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @borrowbooks }
      end
    end
  end

  def overdue
    @finepay = HistoryRequest.where("fines > 0")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finepay }
    end
  end

  def approval
    @approvals = Librarian.where(status: "no")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @approvals}
    end
  end

  def approved
    lib = params[:lib_email]
    if !lib.nil?
      @librarian = Librarian.find_by_email(lib)
      if !@librarian.nil?
        @librarian.status= "yes"
        @librarian.password_digest = "$2a$12$HWPzlzLwJgPMkp9ro3dQzuTTLqiAe8V2IDy52dzA3WCf7faKeDdu"
        @librarian.save!
#          if @librarian.update!(status: "yes")
            respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @librarian}
            end
        # end
      else
        redirect_to admins_approval_path, alert: "not happening cus no value in library"
      end
    else
      redirect_to admins_approval_path, alert: "not happening #{lib}"
    end
  end

  def admin_edit_librarian
    @librarian = Librarian.find(params[:id])
  end

  private
  def admin_params
    params.require(:admin).permit(:email, :name, :password)
  end
end
