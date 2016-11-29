class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    #debugger
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.name}!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end
