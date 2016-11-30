class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
    @form_button_text = "Create my account"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    #debugger
  end

  def edit
    @user = User.find(params[:id])
    @title = @user.name
    @form_button_text = "Save my changes"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
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
