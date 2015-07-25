class QuotesController < ApplicationController

  before_action :require_user, only: [:new, :edit, :delete]

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

    redirect_to quotes_path
  end
  
  def new
    @quote = Quote.new
  end
  
  def create 
    @quote = current_user.quotes.new(quote_params) 
    if @quote.save
      redirect_to quotes_path
    else
      render 'new' 
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
    @editing_quote = Quote.find(params[:id])
  end
  
  def update
    @quote = Quote.find(params[:id])
    
    if @quote.update_attributes(quote_params)
      redirect_to(:action => 'show', :id => @quote.id)
    else
      render 'edit'
    end
  end
  
  private
    def quote_params
      params.require(:quote).permit(:content)
    end

end
