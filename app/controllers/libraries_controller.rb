class LibrariesController < ApplicationController
  def edit
    @library = Library.find(params[:id])
  end

  def show

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
