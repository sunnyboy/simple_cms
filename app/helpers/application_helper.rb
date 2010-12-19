module ApplicationHelper
  
  def action_links_tag(model_name, nested_object = "")
    # nested_object is the name of upper object in hierarchy tree
    # nested_object_parameter = ""
    #     if !nested_object.blank?
    #       params[:#{nested_object}_id] = "@#{nested_object}.id"
    #       link_to("Show", params.merge (:action=>"show", :id=> model_name.id), {:class=>"action show round center"} )  +
    #       link_to("Edit", {:action=>"edit", :id=> model_name.id },      nested_object_parameter, :class=>"action edit round center" ) +
    #       link_to("Delete", {:action=>"delete", :id=> model_name.id },  nested_object_parameter, :class=>"action delete round center")
    #     end
    link_to("Show", {:action=>"show", :id => model_name.id}, :class=>"action show round center") +
    link_to("Edit", {:action=>"edit", :id => model_name.id}, :class=>"action edit round center") +
    link_to("Delete", {:action=>"delete", :id => model_name.id}, :class=>"action delete round center")
  end
  def status_tag(boolean, options={})
    options[:true]        ||=''
    options[:true_class]  ||='status true'
    options[:false]       ||=''
    options[:false_class] ||='status false'
    
    if boolean
      content_tag(:span, options[:true], :class=>options[:true_class])
    else
      content_tag(:span, options[:false], :class=>options[:false_class])
    end      
  end
  def error_messages_for (object)
    render(:partial=>"shared/error_messages", :locals=>{:object=>object})
  end
end

