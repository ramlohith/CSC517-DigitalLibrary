class StudentsController < ApplicationController
  def history_request
    flash[:alert] = ""
    bookchangenumber = false
    @student = Student.find(session[:id])
    check = params[:book_ids].nil?
    if !check
      obj = HistoryRequest.new
      checkout_list = params[:book_ids].collect {|id| id.to_i}
      checkout_list.each do |id|
        book = Book.find(id)
        if obj.checkoutavailability(@student.email, @student.maxbook)
          flash[:alert] = "Maximum checkout books already reached!"
          break
        elsif book.number_available > 0 && !book.special
          obj = HistoryRequest.new(:library_name => book.library, :isbn => book.isbn, :status => "Checked Out" , :student_name => @student.name , :student_email => @student.email)
          LibraryMailer.library_mailer(@student).deliver
          obj.save
          bookchangenumber = true
        elsif book.special && book.number_available > 0
          obj = HistoryRequest.new(:library_name => book.library, :isbn => book.isbn, :status => "Waiting for Approval" , :student_name => @student.name , :student_email => @student.email)
          apprvl = ApprovalRequest.new(:student_email => @student.email, :isbn => book.isbn, :title => book.title, :author => book.author, :edition => book.edition, :university => book.university)
          obj.save
          apprvl.save
        elsif book.number_available == 0
          obj = HistoryRequest.new(:library_name => book.library, :isbn => book.isbn, :status => "On Hold" , :student_name => @student.name , :student_email => @student.email)
          book.number_holdrequest = book.number_holdrequest + 1
          holdreq = HoldRequest.new(:student_email => @student.email, :student_name => @student.name, :isbn => book.isbn, :title => book.title, :author => book.author, :edition => book.edition, :university => book.university)
          obj.save
          book.save
          holdreq.save
          flash[:alert] = "Book sent to Hold request. Please wait till books are returned."
        end
        if bookchangenumber == true
          book.number_available = book.number_available - 1
          book.number_checkedout = book.number_checkedout + 1
          book.save
        end
      end
      end
    @hist_req = HistoryRequest.where(student_email:@student.email).order(updated_at: :desc)
  end

  def new
    @student = Student.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  def index
    @student = Student.find(session[:id])
    @bookmark = Bookmark.where(student_email: @student.email)
    @history_request = HistoryRequest.where(student_email: @student.email)
    totalfine = 0
    if !@history_request.nil?
      @history_request.each do |hist|
        totalfine = totalfine + hist.evaluatebooks(hist.isbn)
      end
    end
      @history_request_totalfines = HistoryRequest.new(:fines => totalfine)
      @history_request = HistoryRequest.where(student_email: @student.email).where('fines > 0')
      render 'students/index'
    end

  def library_list
    @libraries = Library.all
  end
  def books
    @books = Book.all
    @student = Student.find(session[:id])
  end

  def bookmark
    render "students/bookmark"
  end

  def show
    @student = Student.find(session[:id])
    my_render_type = params[:type]
    if my_render_type == "history_request"
      @hist_req = HistoryRequest.where(student_email:@student.email).order(updated_at: :desc)
      render "students/history_request"
    elsif my_render_type == "bookmark"
      books_id = params[:book_id].to_i
      bookmark = Bookmark.new
      bookmark.createnewbookmark(books_id,@student.email, @student.name)
      redirect_to students_books_path(type: "books")
    elsif my_render_type == "book_return"
        hist_id = params[:hist_id].to_i
        histreq_obj = HistoryRequest.find(hist_id)
        histreq_obj.setreturn
        histreq_obj.save
        redirect_to students_books_path(type: "history_request")
    elsif my_render_type == "delete_reservation"
      hist_id = params[:hist_id].to_i
      histreq_obj = HistoryRequest.find(hist_id)
      if histreq_obj.status == "Waiting for Approval"
        apprvl_obj = ApprovalRequest.where(:student_email => @student.email, :isbn => histreq_obj.isbn).first
        apprvl_obj.destroy
      end
      histreq_obj.destroy
      book_obj = Book.where(:isbn => histreq_obj.isbn).first
      book_obj.number_holdrequest = book_obj.number_holdrequest - 1
      book_obj.save
      redirect_to students_books_path(type: "history_request")
      else
      render "students/index" #EDIT THIS!!
    end
  end

  def create
    @student = Student.new(student_params)
    if @student.education == "undergrad"
      @student.maxbook = 2
    elsif @student.education == "grad"
      @student.maxbook = 4
    elsif @student.education == "phd"
      @student.maxbook = 6
    else
      @student.maxbook = 2
    end
    if @student.save
      redirect_to students_login_url, alert: "Registration Successful, Please login!!"
    else
      redirect_to new_student_path, alert: "OOPS!! Problem Occurred. Please enter details again!"
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @bookmark = Bookmark.where(student_email: @student.email)
    @history_request = HistoryRequest.where(student_email: @student.email)
    totalfine = 0
    if !@history_request.nil?
      @history_request.each do |hist|
        totalfine = totalfine + hist.evaluatebooks(hist.isbn)
      end
    end
    @history_request_totalfines = HistoryRequest.new(:fines => totalfine)
    @history_request = HistoryRequest.where(student_email: @student.email).where('fines > 0')

    respond_to do |format|
      if @student.update(email: params[:student][:email], name: params[:student][:name], password: params[:student][:password])
        format.html { render 'students/index', alert: 'Student successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to admins_allstudents_path}
      format.json { head :no_content }
    end
  end



  def admin_edit
    @student = Student.find(params[:id])
  end

  def admin_show
    @student = Student.find(params[:id])
  end

  def admin_update
    @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update(email: params[:student][:email], name: params[:student][:name],
                         password: params[:student][:password],
                         education: params[:student][:education],
                         university: params[:student][:education]
      )
        format.html { redirect_to admins_users_path, alert: 'Student successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def student_params
    params.require(:student).permit(:email, :name, :password, :education, :university)
  end
  end