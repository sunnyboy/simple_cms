class SectionsController < ApplicationController

  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
 
  before_filter :confirm_logged_in
  before_filter :find_page
  
  def index
    list
    render("list")
  end
  def list
    @sections = Section.sorted.where(:page_id => @page.id)
    session[:section_page]      = params[:page]
    session[:section_search]    = params[:search]
    session[:section_sort]      = params[:sort]
    session[:section_direction] = params[:direction]
  end
  def show
    @section = Section.find(params[:id])
  end
  def new 
    @section = Section.new(:name => "", :page_id => @page.id)
    @section_count = @page.sections.size + 1
    @pages = Page.order("position ASC")
  end
  def create
    new_position = params[:section].delete(:position)
    # Instantiate a new object using form parameters
    @section = Section.new(params[:section])
    # Save the object
    if @section.save
      @section.move_to_position(new_position)
      # If the save succeeds, redirect to the list action
      flash[:notice]="Section created successfuly."
      redirect_to(:action=>"list", :id => @section.id, :page_id => @section.page_id)
    else
      # If save fails, redisplay the form so that user can fix the problems
       @section_count = @page.sections.size + 1
      render("new")
    end      
  end
  def edit
     @section = Section.find(params[:id])
      @section_count = @page.sections.size
      @pages = Page.order("position ASC")
  end
  def update
    # Find object using form parameters
    @section = Section.find(params[:id])
    new_position = params[:section].delete(:position)
    # Update the object
    if @section.update_attributes(params[:section])
      @section.move_to_position(new_position)
      # If the update succeeds, redirect to the list action
      flash[:notice]="Section updated successfuly"
      redirect_to(:action=>"list", :id => @section.id, :page_id => @section.page_id)
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@section.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
       @section_count = @page.sections.size + 1
       @pages = Page.order("position ASC")
      render("edit")
    end      
  end
  def delete
     @section = Section.find(params[:id])
  end
  def destroy
     section = Section.find(params[:id])
     section.move_to_position(nil)
     section.destroy
     flash[:notice]="Section destroyed successfuly"
     redirect_to(:action=>"list", :id => @section.id, :page_id => @page.id)
  end
  private
  def find_page
    @page = Page.find_by_id(params[:page_id]) if params[:page_id]
  end
end