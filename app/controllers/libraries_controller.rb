class LibrariesController < ApplicationController
  def edit
    @library = Library.find(params[:id])
  end

  def update

  end

  def library_param

  end

end
