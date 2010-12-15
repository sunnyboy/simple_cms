class PagesController < ApplicationController
  
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
  
  before_filter :confirm_logged_in, :except=>[:login, :attempt_login, :logout]
  
  def index
    list
    render("list")
  end
  
  def list
    @pages = Page.order("pages.position ASC")
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new 
    @page = Page.new(:name => "")
    @page_count = Page.count + 1
  end
  
  def create
    # Instantiate a new object using form parameters
    @page = Page.new(params[:page])
    # Save the object
    if @page.save
      # If the save succeeds, redirect to the list action
      flash[:notice]="Page created successfuly."
      redirect_to(:action=>"list")
    else
      # If save fails, redisplay the form so that user can fix the problems
       @page_count = Page.count + 1
      render("new")
    end      
  end
  
  def edit
     @page = Page.find(params[:id])
      @page_count = Page.count
  end
 
  def update
    # Find object using form parameters
    @page = Page.find(params[:id])
    # Update the object
    if @page.update_attributes(params[:page])
      # If the update succeeds, redirect to the list action
      flash[:notice]="Page updated successfuly"
      redirect_to(:action=>"list")
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@page.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
      @page_count = Page.count
      render("edit")
    end      
  end
 
  def delete
     @page = Page.find(params[:id])
  end
  
  def destroy
     Page.find(params[:id]).destroy
     flash[:notice]="Page destroyed successfuly"
     redirect_to(:action=>"list")
  end
  
end
