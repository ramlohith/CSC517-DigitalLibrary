class BooksController < ApplicationController
    def edit
      @book = Book.find(params[:id])
    end

    def update

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
      if @book.save
        redirect_to books_index_url
      else
        redirect_to new_book_path , alert: "Some error occurred"
      end
    end

    def show
      @book = Book.find(params[:book_id])
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @book }
      end
    end

    def destroy
      @book = Book.find(params[:id])
      @book.destroy

      respond_to do |format|
        format.html { redirect_to books_index_url }
        format.json { head :no_content }
      end
    end


    private
    def book_params
      params.require(:book).permit(:isbn, :title, :author, :language, :published, :edition, :image,
                                   :subject, :summary, :special, :library, :university,
                                   :number_available, :number_checkedout, :number_holdrequest
                                   );
    end

end
