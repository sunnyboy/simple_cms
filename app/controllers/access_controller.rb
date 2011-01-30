class AccessController < ApplicationController

  layout "admin"
  before_filter :request_separator  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index    
    menu
    render ("menu")
  end
  def menu
    # display text and links
  end
  def login
    # login form
  end
  def attempt_login   
    authorized_user=AdminUser.authenticate(params[:username], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You are logged in."
      redirect_to(:action => "menu")
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => "login")
    end
  end
  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice]="You have been logged out."
    redirect_to(:action=>"login")
  end
  private
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:action => "login")
      return false # halts the before filter
    else
      return true
    end
  end
end
