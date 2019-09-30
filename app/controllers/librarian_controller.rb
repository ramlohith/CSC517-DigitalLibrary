class LibrarianController < ApplicationController
    def index
    end

    def new
      @librarian = Librarian.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @librarian }
      end
    end

    def create
      @librarian = Librarian.new(librarian_params)
      if @librarian.save
        redirect_to librarian_login_url, alert: "Registration Successful, Please login!!"
      else
        redirect_to new_student_url, alert: "OOPS!! Problem Occurred. Please enter details again!"
      end
    end

    def show

    end

    def edit
      @librarian = Librarian.find(params[:id])
    end

    def update
      @librarian = Librarian.find(params[:id])
      respond_to do |format|
        if @librarian.update(librarian_params)
          format.html { render 'librarian/index', alert: 'Student successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @librarian.errors, status: :unprocessable_entity }
        end
      end

    end

    private
    def librarian_params
      params.require(:librarian).permit(:email, :name, :password, :library)
    end
  end


