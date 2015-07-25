class UsersController < ApplicationController
  
  def new
    @user = User.new
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to messages_path
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
  
end