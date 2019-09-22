class StudentsController < ApplicationController

  def new

  end
  def index

  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
      redirect_to login_index_path
    else
      flash[:notice] = "Problem Occurred"
      flash[:color] = "invalid"
      redirect_to @student
    end
  end

  private
  def student_params
    params.require(:student).permit(:email, :name, :password, :education, :university )
  end
end
