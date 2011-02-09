class StoriesController < ApplicationController
  
  helper_method :sort_column, :sort_direction #toto mi umozni dostupnost metod z Views a Helperov celej aplikacie
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
  
  before_filter :confirm_logged_in, :request_separator
  caches_action :list, :layout => false
  
  def index
    list
    render("list")
  end
  def list
    @stories_grid = initialize_grid(Story, :per_page => 8)
  end
  def show
    @story = Story.find(params[:id])
  end
  def new 
    @story = Story.new(:name => "")
    @story_count = Story.count + 1
  end
  def create
    new_position = params[:story].delete(:position)
    # Instantiate a new object using form parameters
    @story = Story.new(params[:story])
    # Save the object
    if @story.save
      @story.move_to_position(new_position)
      # If the save succeeds, redirect to the list action
      flash[:notice]="Story created successfuly."
      redirect_to(:action=>"list")
    else
      # If save fails, redisplay the form so that user can fix the problems
      @story_count = Story.count + 1      
      render("new")
    end
  end
  def edit
     @story = Story.find(params[:id])
     @story_count = Story.count
  end
  def update
    # Find object using form parameters
    @story = Story.find(params[:id])
    new_position = params[:story].delete(:position)
    # Update the object
    if @story.update_attributes(params[:story])
      # If the update succeeds, redirect to the list action
      @story.move_to_position(new_position)
      flash[:notice]="Story updated successfuly"
      
      redirect_to(:action=>"list", 
      	          :page => session[:story_page], 
				          :sort => session[:story_sort], 
				          :direction => session[:story_direction],
				          :search => session[:story_search] )
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@story.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
      @Story.count = Story.count
      render("edit")
    end
  end
  def update_all
    
     @story = Story.all
     @story.each do |story|
       story.update_attributes(:position => story.id)
       puts story.id.to_s
     end
    
    # puts params.inspect
    #     @stories = Story.search(params[:search]).order(sort_column+" "+sort_direction).paginate(:per_page => 10, :page => params[:page])
    #     @stories.each do |story|
    #       gets
    #       puts "SUB ID>>>>>>>>>>>>>>>>>>" +  Story.id.to_s
    #       puts "POS ORIGINAL>>>>>>>>>>>>>>" +  Story.position.to_s
    # 
    #       
    #       story.move_to_position(story.id) 
    #       story.update_attributes(:position => story.id)
    #       puts "NEW>>>>>>>>>>>>>>" +  story.position.to_s
    #       
    #     end
    flash[:notice]="Stories positions successfuly updated"
    redirect_to(:action=>"list", 
                :page => params[:page], 
                :sort => params[:sort], 
                :direction => params[:direction], 
                :search => params[:search])
  end  
  def delete
     @story = Story.find(params[:id])
  end
  def destroy
    story = Story.find(params[:id])
    Story.move_to_position(nil)
    flash[:notice]="story destroyed successfuly"    
    redirect_to(:action=>"list", 
    	          :page => session[:story_page], 
			          :sort => session[:story_sort], 
			          :direction => session[:story_direction],
			          :search => session[:story_search] )
  end
  def javascript
    # Len pre demonštračné účely-> nemá žiadnu funkciu
    # Sa môže vymazať
  end
  def text_helpers
    # Len pre demonštračné účely-> nemá žiadnu funkciu
    # Sa môže vymazať
  end
  def escape_output
    # Len pre demonštračné účely-> nemá žiadnu funkciu
    # Sa môže vymazať
  end
  def process_issues
    if params[:grid] && params[:grid][:selected]
      # processing tasks
      flash[:notice] = 'Selected tasks: ' + params[:grid][:selected].join(', ')
    end
    redirect_to story_index_path
  end
  private  
  def sort_column  
    Story.column_names.include?(params[:sort]) ? params[:sort] : "position"  
    # ak nieje hodnota params[:sort] z pola platnych nazvov columns tak nastavy default hodnotu
  end      
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
    #ak nieje hodnota params[:direction] z pola [asc desc] tak nastavy default hodnotu
  end

end
