module ApplicationHelper
  def layout_tabs(record)
    # universal tab generator
    puts record.class.to_s
    model_name = record.class.to_s.downcase.to_sym
    tab_map = {
      site: ["Site Details", "Basins", "Properties"],
      basin: ["Basin Details", "Geometry", "Properties"],
      settings: ["Settings"],
      users: ["User Details", "Preferences"]
    }
    ans = ""
    return "<li>unknown</li>".html_safe if !tab_map.keys.include?(model_name)
    tab_map[model_name].each_with_index do |tab, idx|
      tab_name = tab.underscore.gsub(" ","_")
      active = (request.params["tab"].nil? && idx == 0) || request.params["tab"] == tab_name ? " class='active'" : ""
      ans += "<li#{active}>#{link_to(tab, self.send("edit_#{record.class.to_s.downcase}_path", record, tab: tab_name))}</li>\n"
    end
    ans.html_safe
  end
  
  #options:
  # => collection => assume, name,id change to select
  # => label_class
  # => control_class
  #
  #<div class="form-group" id="form-group">
  #  <%= f.label :site_id, class: "col-sm-2 control-label" %>
  #  <div class="col-sm-10">
  #    <%= f.select :site_id, current_user.customer.sites.unarchived.ordered.map{|l| [l.name, l.id] }, {}, class: "form-control" %>
  #  </div>
  #</div>
  def bootstrap_form_field(form_ref, field, options = {})
    field_class_name = "#{form_ref.object.class.name.underscore.downcase}_#{field}"
    label_class = "col-sm-4 control-label"
    label_class ||= options.fetch(:label_class, nil)
    control_class = "col-sm-8"
    control_class ||= options.fetch(:control_class, nil)
    is_hidden = options.fetch(:hidden, false)
    help_text = options.fetch(:help_text, nil)
    collection = options.fetch(:collection, nil)
    text_rows = options.fetch(:text_rows, nil)
    collection_mapped = options.fetch(:collection_mapped, nil)
    collection_mapped = collection.map{|l| [l.name, l.id] } if collection_mapped.nil? && !collection.nil?
    placeholder = options.fetch(:placeholder, field.to_s)
    result = "<div class=\"form-group #{field_class_name}\" id=\"form-group\">\n"
    result.gsub!("id=", "style=\"display:none;\" id=") if is_hidden
    result += form_ref.label field, class: label_class
    result += "\n<div class=\"#{control_class}\">\n"
    if !collection_mapped.nil?
      result += form_ref.select(field, collection_mapped, {}, {class: "form-control", id: field_class_name})
    elsif !text_rows.nil? 
      result += form_ref.text_area(field, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder)
    else
      result += form_ref.text_field(field, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder)
    end
    result += "\n<span class=\"help-block small\" style=\"display:inline;\">#{help_text}</span>\n" unless help_text.nil?
    result += "\n</div>\n</div>\n"
  end
end
