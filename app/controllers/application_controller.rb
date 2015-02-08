class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :login, :logout, :authenticate_user, :check_current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] ||= user[:id]
  end

  def logout
    session[:user_id] = nil
  end

  def authenticate_user
    if current_user.nil?
      redirect_to login_path
    end
  end

  def check_current_user(user)
    user == current_user
  end

end
