class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new]
  before_action :require_logged_in, only: [:show]
  before_action :require_user_owner, only: [:edit, :delete]
  before_action :require_admin, only: [:admin]

  def admin
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      UserNotifier.send_signup_email(@user).deliver
      redirect_to root_url, :notice => 'Account created!'
    else
      redirect_to '/signup'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    UserNotifier.send_account_deletion_email(@user).deliver
    @user.destroy
    session[:user_id] = nil
    
    redirect_to root_url, :notice => 'Account deleted! Bye :/'
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
end