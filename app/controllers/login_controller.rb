class LoginController < ApplicationController

    def new

    end

    def create

    end

    def destroy
      session[:user_id] = nil
      redirect_to login_url , alert: "Logged Out"
    end

  end



