class StudentsController < ApplicationController
  def history_request
    @student = Student.find(session[:id])
    check = params[:book_ids].nil?
    if !check
      historyreq = HistoryRequest.where(student_email:@student.email, status:'Checked Out')
      checkout_list = params[:book_ids].collect {|id| id.to_i}
      checkout_list.each do |id|
        book = Book.find(id)
        if historyreq.count > @student.maxbook
          flash[:alert] = "Maximum checkout books already reached!"
          break
        elsif book.number_available > 0 && !book.special
          obj = HistoryRequest.new(:library_name => book.library, :isbn => book.isbn, :status => "Checked Out" , :student_name => @student.name , :student_email => @student.email)
          LibraryMailer.library_mailer(@student).deliver
          book.number_available = book.number_available - 1
          book.number_checkedout = book.number_checkedout + 1
          obj.save
          book.save
          break
        elsif book.special && book.number_available > 0
          obj = HistoryRequest.new(:library_name => book.library, :isbn => book.isbn, :status => "Waiting for Approval" , :student_name => @student.name , :student_email => @student.email)
          book.number_available = book.number_available - 1
          book.number_checkedout = book.number_checkedout + 1
          apprvl = ApprovalRequest.new(:student_email => @student.email, :isbn => book.isbn, :title => book.title, :author => book.author, :edition => book.edition, :university => book.university)
          book.save
          obj.save
          apprvl.save
          break
        elsif book.number_available == 0
          obj = HistoryRequest.new(:library_name => book.library, :isbn => book.isbn, :status => "On Hold" , :student_name => @student.name , :student_email => @student.email)
          book.number_holdrequest = book.number_holdrequest + 1
          holdreq = HoldRequest.new(:student_email => @student.email, :student_name => @student.name, :isbn => book.isbn, :title => book.title, :author => book.author, :edition => book.edition, :university => book.university)
          obj.save
          book.save
          holdreq.save
          flash[:alert] = "Book sent to Hold request. Please wait till books are returned."
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
        @book = Book.where(isbn: hist.isbn).first
        @library = Library.where(university: @book.university, name: @book.library).first
        hist = hist.calculatefines(@library.maxdays, @library.fine)
        totalfine = totalfine + hist.fines
        hist.save
      end
      @history_request_totalfines = HistoryRequest.new(:fines => totalfine)
      @history_request = HistoryRequest.where("fines > 0", student_email: @student.email)
      render 'students/index'
    end
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
      book = Book.find(books_id)
      obj = Bookmark.new(:isbn => book.isbn , :title => book.title, :author => book.author, :edition => book.edition, :student_name => @student.name, :student_email => @student.email)
      obj.save
      redirect_to students_books_path(type: "books")
    elsif my_render_type == "book_return"
        hist_id = params[:hist_id].to_i
        histreq_obj = HistoryRequest.find(hist_id)
        histreq_obj.status = "Returned"
        var_isb = histreq_obj.isbn
        book_obj = Book.where(isbn:var_isb).first
        book_obj.number_available = book_obj.number_available + 1
        book_obj.number_checkedout= book_obj.number_checkedout - 1
        holdreq_obj = HoldRequest.where(isbn: book_obj.isbn).first
        if !holdreq_obj.nil?
          if !book_obj.special
            obj = HistoryRequest.where(isbn: book_obj.isbn, student_email: holdreq_obj.student_email ).first
            obj.status = "Checked Out"
            LibraryMailer.library_mailer(@student).deliver
            book_obj.number_available = book_obj.number_available - 1
            book_obj.number_checkedout = book_obj.number_checkedout + 1
            obj.save

          elsif book_obj.special
            obj = HistoryRequest.where(isbn: book_obj.isbn, student_email: holdreq_obj.student_email ).first
            obj.status = "Waiting for Approval"
            book_obj.number_available = book_obj.number_available - 1
            book_obj.number_checkedout = book_obj.number_checkedout + 1
            apprvl = ApprovalRequest.new(:student_email => holdreq_obj.student_email, :isbn => book_obj.isbn, :title => book_obj.title, :author => book_obj.author, :edition => book_obj.edition, :university => book_obj.university)

            obj.save
            apprvl.save
          end
          holdreq_obj.delete
        end
        book_obj.save
        histreq_obj.save
        redirect_to students_books_path(type: "history_request")
    elsif my_render_type == "delete_reservation"
      hist_id = params[:hist_id].to_i
      histreq_obj = HistoryRequest.find(hist_id)
      histreq_obj.destroy
      apprvl_obj = ApprovalRequest.where(:student_email => @student.email, :isbn => histreq_obj.isbn).first
      apprvl_obj.destroy
      book_obj = Book.where(:isbn => histreq_obj.isbn).first
      book_obj.number_available = book_obj.number_available + 1
      book_obj.number_holdrequest = book_obj.number_holdrequest - 1
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

  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to admins_allstudents_path}
      format.json { head :no_content }
    end
  end

  def update
    @student = Student.find(params[:id])

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
        format.html { render 'admins/index', alert: 'Student successfully updated.' }
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