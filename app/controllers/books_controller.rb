class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def edit
    bookid = params[:book_id]
    @book = Book.find(bookid)
  end

  def show
    @book = Book.find(params[:book_id])
    render "books/show"
  end

  def update
    @book = Book.find(params[:id])
    respond_to do |format|
      if @book.update(isbn: params[:book][:isbn],title: params[:book][:title],author: params[:book][:author],edition: params[:book][:edition],summary: params[:book][:summary],library: params[:book][:library])
        format.html { render 'librarians/index', notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action:"edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end
  def set_recipe
    @book = Book.find(params[:id])
  end
  def book_param
    params.require(:book).permit(:isbn,:title,:author,:edition,:summary,:library)
  end
end
