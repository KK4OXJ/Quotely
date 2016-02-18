class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :quote_owner

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def quote_owner
    @owner = @quote.user
  end

  def require_logged_in
    redirect_to login_path unless current_user
  end

  def require_logged_out
    redirect_to root_path unless !current_user
  end

  def require_quote_owner
    @quote = Quote.find(params[:id])
    
    redirect_to root_path unless current_user == @quote.user || current_user.admin? == true
  end

  def require_user_owner
    @user = User.find(params[:id])

    redirect_to root_path unless current_user == @user || current_user.admin? == true
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end