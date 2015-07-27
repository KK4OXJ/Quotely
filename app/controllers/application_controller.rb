class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user 
    redirect_to login_path unless current_user
  end

  def require_owner
    @quote = Quote.find(params[:id])
    @user = User.find(params[:id])
    
    redirect_to quotes_path unless current_user.email == @quote.user.email || current_user.email == @user.email
  end

  def require_logged_out
    redirect_to quotes_path unless !current_user
  end

  def require_admin
    redirect_to quotes_path unless current_user.admin?
  end

end
