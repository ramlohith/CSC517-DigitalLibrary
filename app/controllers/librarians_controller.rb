class LibrariansController < ApplicationController
  def new
    @librarian = Librarian.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @librarian }
    end
  end

  def history_request
    @librarian = Librarian.find(session[:id])
    #@his_req = HistoryRequest.where(library_name:@librarian.library,status:"Waiting for Approval")
    @his_req = HistoryRequest.new(:library_name => "Hunt", :status => "test")
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

  def show
    @librarian = Librarian.find(session[:id])
    @hist_request = HistoryRequest.where(:library_name=>@librarian.library,:status=>"Waiting for Approval")
    render "librarians/history_request"
  end

  def books
    @books = Book.all
  end


  def index

  end

  def create
    @librarian = Librarian.new(librarian_params)
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

