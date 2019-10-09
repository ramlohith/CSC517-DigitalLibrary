class BooksController < ApplicationController
  def edit
    bookid = params[:book_id]
    @book = Book.find(bookid)
  end

  def update
    @book = Book.find(params[:id])
    @library = Library.find_by_name(@book.library)
    if !@library.nil?
      @book.university = @library.university
    end
      respond_to do |format|
          if @book.update(isbn: params[:book][:isbn],
                          title: params[:book][:title],
                          author: params[:book][:author],
                          edition: params[:book][:edition],
                          language: params[:book][:language],
                          published: params[:book][:published],
                          subject: params[:book][:subject],
                          summary: params[:book][:summary],
                          special: params[:book][:special],
                          library: params[:book][:library],
                          number_available: params[:book][:number_available],
                          number_checkedout: params[:book][:number_checkedout],
                          number_holdrequest: params[:book][:number_holdrequest])
            format.html { render books_show_path, alert: 'Book was successfully updated.' }
            format.json { head :no_content }
          else
            format.json { render json: @books }
            format.html { render action:"edit" }
            format.json { render json: @book.errors, status: :unprocessable_entity }
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
    bookid = params[:book_id]
    @book = Book.find(bookid)
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
                                 :subject, :summary, :special, :library, :number_available , :number_checkedout,
                                 :number_holdrequest);
  end
end