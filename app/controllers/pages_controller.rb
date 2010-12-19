class PagesController < ApplicationController
  
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
  before_filter :confirm_logged_in
  before_filter :find_subject
  
  def index
    list
    render("list")
  end
  def list
    if params[:subject_id]
      @pages = Page.sorted.where(:subject_id => @subject.id)
    else
      @pages = Page.order("pages.position ASC")
    end
  end
  def show
    @page = Page.find(params[:id])
  end
  def new 
    @page = Page.new(:name => "", :subject_id => @subject.id)
    @page_count = @subject.pages.size + 1
    @subjects = Subject.order("position ASC")
  end
  def create
    new_position = params[:page].delete(:position)
    # Instantiate a new object using form parameters
    @page = Page.new(params[:page])
    # Save the object
    if @page.save
      @page.move_to_position(new_position)
      # If the save succeeds, redirect to the list action
      flash[:notice]="Page created successfuly."
      redirect_to(:action=>"list", :id => @page.id, :subject_id => @page.subject_id)
      # :subject_id => @page.subject_id zachova parameter subject_id pri prechode kontrolermy
    else
      # If save fails, redisplay the form so that user can fix the problems
       @page_count = @subject.pages.size + 1
      render("new")
    end      
  end
  def edit
    @page = Page.find(params[:id])
    @page_count = @subject.pages.size
    @subjects = Subject.order("position ASC")
  end
  def update
    # Find object using form parameters
    @page = Page.find(params[:id])
    new_position = params[:page].delete(:position)
    # Update the object
    if @page.update_attributes(params[:page])
      @page.move_to_position(new_position)
      # If the update succeeds, redirect to the list action
      flash[:notice]="Page updated successfuly"
      redirect_to(:action=>"list", :id => @page.id, :subject_id => @page.subject_id)
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@page.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
      @page_count = @subject.pages.size
      @subjects = Subject.order("position ASC")
      render("edit")
    end      
  end
  def delete
     @page = Page.find(params[:id])
  end
  def destroy
     page = Page.find(params[:id])
     page.move_to_position(nil)
     page.destroy
     flash[:notice]="Page destroyed successfuly"
     redirect_to(:action=>"list", :id => @page.id, :subject_id => @subject.id)
  end
  private
  def find_subject
    if params[:subject_id]
      @subject = Subject.find_by_id(params[:subject_id])
    end
  end
end
