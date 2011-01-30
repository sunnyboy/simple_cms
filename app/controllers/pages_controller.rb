class PagesController < ApplicationController
  
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
  helper_method :sort_column, :sort_direction  #toto mi umozni dostupnost metod z Views a Helperov celej aplikacie
  before_filter :confirm_logged_in
  before_filter :find_story, :request_separator

  def index
    list
    render("list")
  end
  def list
    if params[:story_id]
      @pages = Page.where(:story_id => @story.id)
      @pages = @pages.search(params[:search]).order(sort_column+" "+sort_direction)
      @pages = @pages.paginate(:per_page => 10, :page => params[:page])
      puts @pages.inspect
    else
      @pages = Page.search(params[:search]).order(sort_column+" "+sort_direction).paginate(:per_page => 10, :page => params[:page])
    end
    session[:page_page]      = params[:page]
    session[:page_search]    = params[:search]
    session[:page_sort]      = params[:sort]
    session[:page_direction] = params[:direction]    
  end
  def show
    @page = Page.find(params[:id])
  end
  def new 
    @page = Page.new(:name => "", :story_id => @story.id)
    @page_count = @story.pages.size + 1
    @stories = Story.order("position ASC")
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
      redirect_to(:action=>"list", :id => @page.id, :story_id => @page.story_id)
      # :story_id => @page.story_id zachova parameter story_id pri prechode kontrolermy
    else
      # If save fails, redisplay the form so that user can fix the problems
       @page_count = @story.pages.size + 1
      render("new")
      end      
  end
  def edit
    @page = Page.find(params[:id])
    @page_count = @story.pages.size
    @stories = Story.order("position ASC")
  end
  def update
    # Find object using form parameters
    @page = Page.find(params[:id])
    new_position = params[:page].delete(:position)
    # Update the object
    if @page.update_attributes(params[:page])
      @page.move_to_position(new_position)
      # If the update succeeds, redirect to the index action
      flash[:notice]="Page updated successfuly"
      redirect_to(:action=>"list", :id => @page.id, :story_id => @page.story_id)
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@page.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
      @page_count = @story.pages.size
      @stories = Story.order("position ASC")
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
     redirect_to(:action=>"list", :id => @page.id, :story_id => @story.id)
  end
  private
  def find_story
    if params[:story_id]
      @story = Story.find_by_id(params[:story_id])
    end
  end
  def sort_column  
    Page.column_names.include?(params[:sort]) ? params[:sort] : "position"  
    # ak nieje hodnota params[:sort] z pola platnych nazvov columns tak nastavy default hodnotu
  end      
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
    #ak nieje hodnota params[:direction] z pola [asc desc] tak nastavy default hodnotu
  end
end
