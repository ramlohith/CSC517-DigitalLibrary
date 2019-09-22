class LoginController < ApplicationController
  def index
    #@login = login.new
  end
  def create
    @login = login.find_by_email(params[:email])
    if login && login.authenticate(params[:password])
      session[:user_id] = user.id
     redirect_to root_url, notice: "Logged In!"
    else
      flas.now[:alert] = "Email or password is invalid"
      render "index"
    end
    def destroy
      session[:user_id] = nil
      redirect_to root_url, notice: "Logged Out"
    end
  end

end
