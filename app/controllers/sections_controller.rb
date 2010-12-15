class SectionsController < ApplicationController

  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
 
  before_filter :confirm_logged_in, :except=>[:login, :attempt_login, :logout] 
  
  def index
    list
    render("list")
  end
  
  def list
    @sections = Section.order("sections.position ASC")
  end
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new 
    @section = Section.new(:name => "")
    @section_count = Section.count + 1
  end
  
  def create
    # Instantiate a new object using form parameters
    @section = Section.new(params[:section])
    # Save the object
    if @section.save
      # If the save succeeds, redirect to the list action
      flash[:notice]="Section created successfuly."
      redirect_to(:action=>"list")
    else
      # If save fails, redisplay the form so that user can fix the problems
       @section_count = Section.count + 1
      render("new")
    end      
  end
  
  def edit
     @section = Section.find(params[:id])
      @section_count = Section.count
  end
 
  def update
    # Find object using form parameters
    @section = Section.find(params[:id])
    # Update the object
    if @section.update_attributes(params[:section])
      # If the update succeeds, redirect to the list action
      flash[:notice]="Section updated successfuly"
      redirect_to(:action=>"list")
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@section.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
       @section_count = Section.count
      render("edit")
    end      
  end
 
  def delete
     @section = Section.find(params[:id])
  end
  
  def destroy
     Section.find(params[:id]).destroy
     flash[:notice]="Section destroyed successfuly"
     redirect_to(:action=>"list")
  end

end
