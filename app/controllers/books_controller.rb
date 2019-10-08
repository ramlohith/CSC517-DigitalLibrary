class BooksController < ApplicationController
  def edit
    bookid = params[:book_id]
    @book = Book.find(bookid)
  end

  def update
    @book = Book.find(params[:id])
    url = Rails.application.routes.recognize_path(request.referrer)   #fetch where the call is coming from
    last_controller = url[:controller]
    if last_controller == "librarians"
      respond_to do |format|
          if @book.update(isbn: params[:book][:isbn],
                          title: params[:book][:title],
                          author: params[:book][:author],
                          edition: params[:book][:edition],
                          summary: params[:book][:summary],
                          library: params[:book][:library],
                          number_available: params[:book][:number_available],
                          number_checkedout: params[:book][:number_checkedout],
                          number_holdrequest: params[:book][:number_holdrequest])
            format.html { render 'librarians/index', notice: 'Book was successfully updated.' }
            format.html # new.html.erb
            format.json { head :no_content }
          else
            format.json { render json: @books }
            format.html { render action:"edit" }
            format.json { render json: @library.errors, status: :unprocessable_entity }
          end
        end
    else
      @library = Library.find_by_name(@book.library)
      if !@library.nil?
        @book.university = @library.university
      end
      respond_to do |format|
        if @book.update(isbn: params[:book][:isbn],
                        title: params[:book][:title],
                        author: params[:book][:author],
                        edition: params[:book][:edition],
                        summary: params[:book][:summary],
                        library: params[:book][:library],
                        number_available: params[:book][:number_available],
                        number_checkedout: params[:book][:number_checkedout],
                        number_holdrequest: params[:book][:number_holdrequest])
          format.html { redirect_to admins_index_url, alert: 'Book was successfully updated.' }
          format.html # new.html.erb
          format.json { head :no_content }
        else
          format.json { render json: @books }
          format.html { render action:"edit" }
          format.json { render json: @library.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def index
    @books = Book.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @books }
    end
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  def create
    @book = Book.new(book_params)
    @library = Library.find_by_name(@book.library)
    @book.university = @library.university
    if @book.save
      redirect_to books_index_url
    else
      redirect_to new_book_path , alert: "Some error occurred"
    end
  end

  def show
    @book = Book.find(params[:id])
      render "books/show"
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_index_url }
      format.json { head :no_content }
    end
  end

def set_recipe
  @book = Book.find(params[:id])
end
  private
  def book_params
    params.require(:book).permit(:isbn, :title, :author, :language, :published, :edition, :image,
                                 :subject, :summary, :special, :library, :number_available );
  end

end