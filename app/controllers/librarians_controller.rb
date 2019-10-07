class LibrariansController < ApplicationController
  def new
    @librarian = Librarian.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @librarian }
    end
  end

  def edit
    @librarian = Librarian.find(params[:id])
  end

  def update
    @librarian = Librarian.find(params[:id])
    respond_to do |format|
      if @librarian.update(email: params[:librarian][:email],name: params[:librarian][:name],password: params[:librarian][:password],library: params[:librarian][:library])
        format.html { render 'librarians/index', notice: 'Librarian was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action:"edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin_update_librarian
    @librarian = Librarian.find(params[:id])
    url = Rails.application.routes.recognize_path(request.referrer)   #fetch where the call is coming from
    last_controller = url[:controller]
    if last_controller == "librarians"
      update
    else
      @librarian = Librarian.find(params[:id])
      respond_to do |format|
      if @librarian.update(email: params[:librarian][:email],name: params[:librarian][:name],password: params[:librarian][:password],library: params[:librarian][:library])
        format.html { redirect_to admins_users_path, alert: 'Librarian was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action:"edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
      end
  end

  def admin_show_librarian
    @librarian = Librarian.find(session[:id])
    respond_to do |format|
      format.html {render "librarians/show"}
      format.json { render json: @librarian }
    end
  end
  def show
    @librarian = Librarian.find(session[:id])
    @hold = HistoryRequest.where(:library_name=>@librarian.library,:status=>"Waiting for Approval")
    render "librarians/history_request"
  end

  def checkedout_request
    @librarian = Librarian.find(session[:id])
    @check_request = HistoryRequest.where(:library_name=>@librarian.library,:status=>"Checked Out")
    render "librarians/checkedout_request"
  end

  def borrow
    @librarian = Librarian.find(session[:id])
    @borrow = HistoryRequest.where(:library_name=>@librarian.library)
    render "librarians/borrow"
  end

  def books
    @books = Book.all
  end


  def index

  end

  def create
    @librarian = Librarian.new(librarian_params)
    @librarian.status= "no"
    if @librarian.save
      redirect_to librarians_login_url, alert: "Registration Successful, Please login!!"
    else
      redirect_to new_librarian_path, alert: "OOPS!! Problem Occurred. Please enter details again!"
    end
    end
  end


  def destroy
    bookid = params[:book_id]
    @book = Book.find(bookid)
    @book.destroy
    respond_to do |format|
      format.html { redirect_to librarians_path, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def librarian_params
    params.require(:librarian).permit(:email, :name, :password, :library)
  end

