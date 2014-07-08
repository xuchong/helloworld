class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]


  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User deleted."
    redirect_to(:back)
  end 

  def create

    par = user_params

    par[:user_is_admin] = 1
    par[:user_status] = 0

    @user = User.new(par)    # Not the final implementation!

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user && @user.authenticate(params[:old_password])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    else 
      flash[:error] = "Old password is not correct"
      render 'edit'
    end
  end

  def my_questionnaires
    @user = User.find(params[:id])
    @questionnaires = @user.questionnaires
  end

  def my_answered_questionnaires
    @user = User.find(params[:id])
    @relationships = @user.relationships
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :user_email, :password, :password_confirmation, :user_age, :user_sex, :user_job)
    end

    def signed_in_user
      
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
