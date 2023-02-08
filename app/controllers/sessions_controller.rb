class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:session].present?
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in successfully!"
      else
        flash.now[:alert] = "Invalid email/password combination"
        render "new"
      end
    else
      flash[:alert] = "Session parameter missing"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
