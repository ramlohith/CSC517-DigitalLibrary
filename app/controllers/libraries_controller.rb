class LibrariesController < ApplicationController
  def edit
    @library = Library.find(params[:id])
  end

  def show
    @libraries = Library.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @libraries }
    end
  end

  def index
    @libraries = Library.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @libraries }
    end

  end

  def new
    @library = Library.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @library }
    end
  end

  def create
    @library = Library.new(library_param)
    if @library.save
      redirect_to admins_index_path, alert: "Library successfully created!!"
    else
      redirect_to new_library_path, alert: "OOPS!! Problem Occurred. Please enter details again!"
    end
  end

  def update
    @library = Library.find(params[:id])
    respond_to do |format|
      if @library.update(name: params[:library][:name],university: params[:library][:university],location: params[:library][:location],maxdays: params[:library][:maxdays],fine: params[:library][:fine])
        format.html { render 'librarians/index', notice: 'Library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action:"edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  def library_param
       params.require(:library).permit(:name,:university,:location,:maxdays,:fine)
  end

end
