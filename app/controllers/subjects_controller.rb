class SubjectsController < ApplicationController
  
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
  
  before_filter :confirm_logged_in, :except=>[:login, :attempt_login, :logout]
  
  def index
    list
    render("list")
  end
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  def new 
    @subject = Subject.new(:name => "")
    @subject_count = Subject.count + 1
  end
  
  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(params[:subject])
    # Save the object
    if @subject.save
      # If the save succeeds, redirect to the list action
      flash[:notice]="Subject created successfuly."
      redirect_to(:action=>"list")
    else
      # If save fails, redisplay the form so that user can fix the problems
      @subject_count = Subject.count + 1      
      render("new")
    end      
  end
  
  def edit
     @subject = Subject.find(params[:id])
     @subject_count = Subject.count
  end
 
  def update
    # Find object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(params[:subject])
      # If the update succeeds, redirect to the list action
      flash[:notice]="Subject updated successfuly"
      redirect_to(:action=>"list")
      # Or redirect show action
      # redirect_to(:action=>"show", :id=>@subject.id)
    else
      # If update fails, redisplay the form so that user can fix the problems
      @subject_count = Subject.count
      render("edit")
    end      
  end
 
  def delete
     @subject = Subject.find(params[:id])
  end
  
  def destroy
     Subject.find(params[:id]).destroy
     flash[:notice]="Subject destroyed successfuly"
     redirect_to(:action=>"list")
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
end
