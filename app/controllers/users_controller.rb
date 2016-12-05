class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
    @form_button_text = "Create my account"
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @microposts = @user.microposts.paginate(page: params[:page])
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
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfuly deleted."
    redirect_to users_path
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    # Before filters
  
    # Ensures the user only can edit himself
    def correct_user
      redirect_to root_path unless current_user == User.find(params[:id])
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
  
end
