class LibrariesController < ApplicationController
  def edit
    @library = Library.find(params[:id])
  end

  def update

  end

  def index
    @library = Library.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @library }
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
  @library = Library.new(library_params)
    if @library.save
      redirect_to libraries_index_url
    else
  redirect_to new_library_path , alert: "Some error occurred"
    end
  end

  def show
    @libraries = Library.all
    respond_to do |format|
      format.html # index.html.erb
        format.json { render json: @libraries }
      end
  end

  private
  def library_params
    params.require(:library).permit(:name, :university, :location, :maxdays, :fine)
  end

end
