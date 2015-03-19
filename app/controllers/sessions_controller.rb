class SessionsController < ApplicationController

  def new
    redirect_to home_path if signed_in?
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.full_name}, you have signed in"
      redirect_to home_path
    else
      flash[:danger] = "Your details have not been recognised"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have signed out"
    redirect_to root_path
  end

end