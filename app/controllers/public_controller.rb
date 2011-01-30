class PublicController < ApplicationController
  
  layout "public"
  before_filter :setup_navigation, :request_separator
  
  def index
      # intro text, landing page
  end
  def show
      @page = Page.where(:permalink => params[:id], :visible => true ).first
      redirect_to(:action => 'index') unless @page
  end
  private
  def setup_navigation
    @stories = Story.visible.sorted
  end

end
