class DropboxController < ApplicationController
  def authorize
    if params[:oauth_token] then
           @dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
           @dropbox_session.authorize(params)
           session[:dropbox_session] = @dropbox_session.serialize # re-serialize the authenticated session

           redirect_to :action => 'import'
         else
           @dropbox_session = Dropbox::Session.new('u2gewy9ezpy1jeo', 'lv1q3vgsi2ud1c6')
           session[:dropbox_session] = @dropbox_session.serialize
           redirect_to @dropbox_session.authorize_url(:oauth_callback => url_for(:action => 'authorize'))
         end
  end
  def import
    return redirect_to(:action => 'authorize') unless session[:dropbox_session]
    @dropbox_session = Dropbox::Session.deserialize(session[:dropbox_session])
    return redirect_to(:action => 'authorize') unless @dropbox_session.authorized?
    
    @dropbox_session.mode = :dropbox
    puts '*********************'
    mode = @dropbox_session.mode 
    puts mode.to_s
    puts '*********************'
        
    @folder_list = @dropbox_session.list '/public'
    puts @folder_list.size.to_s
    
    # if request.method == :post then
    #       # dropbox_session.upload params[:file], 'My Uploads'
    #       render :text => 'Uploaded OK'
    #     else
    #       # display a multipart file field form
    #     end
  end
end
