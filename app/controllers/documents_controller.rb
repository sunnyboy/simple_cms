class DocumentsController < ApplicationController
  layout "admin" # Oznamujem kontroleru, ze ma pouzivat layout "admin"  
  before_filter :request_separator
  def index 
    @documents = Document.all
    @documents = Document.search(params[:search]).order(sort_column+" "+sort_direction).paginate(:per_page => 10, :page => params[:page])
    session[:document_page] = params[:page]
    session[:document_search] = params[:search]
    session[:document_sort] = params[:sort]
    session[:document_direction] = params[:direction]    
    respond_to do |format|
      # GET /documents
      # GET /documents.xml
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end
  def show
    @document = Document.find(params[:id])
    respond_to do |format|
      # GET /documents/1
      # GET /documents/1.xml
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end
  def new
    @document = Document.new
    @document_count = Document.count + 1
    respond_to do |format|
      # GET /documents/new
      # GET /documents/new.xml
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      # POST /documents
      # POST /documents.xml
      if @document.save
        puts "Dokument ulozeny"
        format.html { redirect_to(@document, :notice => 'Document was successfully created.') }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        puts "Neulozeny...aka to chyba?"
        format.html { render :action => "new", :notice => 'Sa nevytvoril tento dokument.' }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end 
  def edit
    # GET /documents/1/edit
    @document = Document.find(params[:id])
    @document_count = Document.count
  end  
  def update
    @document = Document.find(params[:id])
    respond_to do |format|
      # PUT /documents/1
      # PUT /documents/1.xml
      puts params[:document].inspect
      if @document.update_attributes(params[:document])
        format.html { 
          flash[:notice]="Subject updated successfuly"
          redirect_to(:action=>"index", 
          	          :page => session[:document_page], 
    				          :sort => session[:document_sort], 
    				          :direction => session[:document_direction],
    				          :search => session[:document_search])
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  def delete
     @document = Document.find(params[:id])
  end  
  def destroy
    @document.destroy
    respond_to do |format|
      # DELETE /documents/1
      # DELETE /documents/1.xml
      format.html { 
        flash[:notice]="Subject destroyed successfuly"
        redirect_to(:action=>"index", 
        	          :page => session[:document_page], 
  				          :sort => session[:document_sort], 
  				          :direction => session[:document_direction],
  				          :search => session[:document_search])
      }
      format.xml  { head :ok }
    end
  end
private
  def sort_column  
    Document.column_names.include?(params[:sort]) ? params[:sort] : "id"  
    # ak nieje hodnota params[:sort] z pola platnych nazvov columns tak nastavy default hodnotu
  end      
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
    #ak nieje hodnota params[:direction] z pola [asc desc] tak nastavy default hodnotu
  end

end
