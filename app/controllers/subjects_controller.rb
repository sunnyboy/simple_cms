class SubjectsController < ApplicationController
  
  helper_method :sort_column, :sort_direction #toto mi umozni dostupnost metod z Views a Helperov celej aplikacie
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"
  
  before_filter :confirm_logged_in
  
  def index
    list
    render("list")
  end
  def list
    @subjects = Subject.search(params[:search])
                        .order(sort_column+" "+sort_direction)
                        .paginate(:per_page => 10, :page => params[:page])
  end
  def show
    @subject = Subject.find(params[:id])
  end
  def new 
    @subject = Subject.new(:name => "")
    @subject_count = Subject.count + 1
  end
  def create
    new_position = params[:subject].delete(:position)
    # Instantiate a new object using form parameters
    @subject = Subject.new(params[:subject])
    # Save the object
    if @subject.save
      @subject.move_to_position(new_position)
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
    new_position = params[:subject].delete(:position)
    # Update the object
    if @subject.update_attributes(params[:subject])
      # If the update succeeds, redirect to the list action
      @subject.move_to_position(new_position)
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
  def update_all
    @subjects = Subject.all
    @subjects.each { |subject| subject.move_to_position(10)}
    redirect_to(:action=>"list")
  end  
  def delete
     @subject = Subject.find(params[:id])
  end
  def destroy
    subject = Subject.find(params[:id])
    subject.move_to_position(nil)
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
  private  
  def sort_column  
    Subject.column_names.include?(params[:sort]) ? params[:sort] : "position"  
    # ak nieje hodnota params[:sort] z pola platnych nazvov columns tak nastavy default hodnotu
  end      
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
    #ak nieje hodnota params[:direction] z pola [asc desc] tak nastavy default hodnotu
  end

end
