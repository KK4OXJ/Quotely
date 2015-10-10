class QuotesController < ApplicationController
  
  before_action :require_logged_in, only: [:new, :edit, :delete]
  before_action :require_quote_owner, only: [:edit, :delete]

  def index
    @quotes = Quote.all
  end

  def show
    @quote = Quote.find(params[:id])
    @user = @quote.user
    @users = User.all
  end
  
  def destroy
    quote = Quote.find(params[:id])
    quote.destroy

    redirect_to root_url, :notice => 'Your Quote was deleted!'
  end
  
  def new
    @quote = Quote.new
  end
  
  def create 
    @quote = current_user.quotes.new(quote_params) 
    @user = current_user
    @users = User.all
    
    if @quote.save
      UserNotifier.send_new_quote_email(@users).deliver
      redirect_to quote_url(@quote), :notice => 'Your Quote was created!'
    else
      render 'new'
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
    @user = @quote.user
  end
  
  def update
    @quote = Quote.find(params[:id])
    
    if @quote.update_attributes(quote_params)
      redirect_to quote_url(@quote), :notice => 'Quote edited successfully!'
    else
      render 'edit'
    end
  end
  
  private
    def quote_params
      params.require(:quote).permit(:content)
    end

end
