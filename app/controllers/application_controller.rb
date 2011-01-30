class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected # pristupne tomuto Classu a vsetkym sub-Classom
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice]="Please log in"
      redirect_to(:controller=>"access", :action=>"login")
      return false # halts the before_filter MUST BE!!!
    else
      return true
    end      
  end
  def request_separator
    puts ""
    puts "***************************************************************"
    puts "**********" + Time.now.to_s + "****************************"
    puts controller_name + " ||| " + action_name
    puts "***************************************************************"    
  end

end
