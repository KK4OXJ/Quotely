class UsersController < ApplicationController

  before_action :require_logged_out, only: [:new]
  before_action :require_owner, only: [:edit]
  # before_action :require_admin, only: [:admin]
  
  def new
    @user = User.new
  end

  def admin
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to quotes_path
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
      redirect_to(:action => 'show', :id => @user.id)
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to messages_path
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :name)
    end
  
end
