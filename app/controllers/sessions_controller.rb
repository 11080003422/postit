class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_username(params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Login successful'
      redirect_to root_path
    else
      flash[:error] = 'There is something wrong with your username or password'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logout successful'
    redirect_to root_path
  end
end