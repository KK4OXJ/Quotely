class UserNotifier < ActionMailer::Base
  default :from => 'zeke@zystvan.com'
  
  def send_signup_email(user)
    @user = user
    mail(:to => @user.email, :subject => 'Thanks for signing up for Quotely!')
  end
  
  def send_new_quote_emails(users)
    @users = users
    
    @users.each do |user|
      @user = user
      mail(:to => @user.email, :subject => 'New Quote on Quotely')
    end
  end
  
  def send_account_deletion_email(user)
    @user = user
    mail(:to => @user.email, :subject => 'Your account on Quotely has been deleted')
  end
end