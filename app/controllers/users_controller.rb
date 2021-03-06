class UsersController < ApplicationController

  def show
    begin
      @user = User.find(params[:id])
      unless @user
        redirect_to root_path
      end
    rescue
      redirect_to root_path
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to root_path, notice: "User created succ"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
