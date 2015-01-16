class SessionsController < ApplicationController

  def index

  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] ||= user.id
      redirect_to root_path
    else
      render "index"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
