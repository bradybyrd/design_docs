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
  #    <%= f.select :site_id, current_user.company.sites.unarchived.ordered.map{|l| [l.name, l.id] }, {}, class: "form-control" %>
  #  </div>
  #</div>
  def bootstrap_form_field(form_ref, field, options = {})
    field_class_name = "#{form_ref.object.class.name.underscore.downcase}_#{field}"
    label_class = options.fetch(:label_class, "col-sm-4 control-label")
    control_class = options.fetch(:control_class, "col-sm-8")
    is_hidden = options.fetch(:hidden, false)
    help_text = options.fetch(:help_text, nil)
    help_text_below = options.fetch(:help_text_below, nil)
    seed_value = options.fetch(:seed_value, "")
    collection = options.fetch(:collection, nil)
    text_rows = options.fetch(:text_rows, nil)
    is_email = options.fetch(:email, nil)
    is_password = options.fetch(:password, nil)
    collection_mapped = options.fetch(:collection_mapped, nil)
    collection_mapped = collection.map{|l| [l.name, l.id] } if collection_mapped.nil? && !collection.nil?
    placeholder = options.fetch(:placeholder, field.to_s)
    result = "<div class=\"form-group #{field_class_name}\" id=\"form-group\">\n"
    result.gsub!("id=", "style=\"display:none;\" id=") if is_hidden
    result += form_ref.label field, class: label_class
    result += "\n<div class=\"#{control_class}\">\n"
    if !collection_mapped.nil?
      result += form_ref.select(field, collection_mapped, {}, {class: "form-control", id: field_class_name})
    elsif is_email
      result += form_ref.email_field(field, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder)
    elsif !text_rows.nil? 
      result += form_ref.text_area(field, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder)
    elsif !is_password.nil? 
      result += form_ref.password_field(field, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder)
    else
      result += form_ref.text_field(field, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder) unless field.is_a?(String)
      result += text_field_tag(field, seed_value, class: "form-control", id: "#{form_ref.object.class.name.underscore.downcase}_#{field}", placeholder: placeholder) if field.is_a?(String)
    end
    result += "\n<span class=\"help-block small\" style=\"display:inline;\">#{help_text}</span>\n" unless help_text.nil?
    result += "\n<span class=\"help-block small\">#{help_text_below}</span>\n" unless help_text_below.nil?
    result += "\n</div>\n</div>\n"
  end

  def bootstrap_property_field(form_ref, property, model_holder, options = {})
    base_name = "props[#{property.id}[]]"
    label_class = options.fetch(:label_class, "col-sm-4 control-label")
    control_class = options.fetch(:control_class, "col-sm-8")
    help_text = property.tip
    collection_mapped = property.choices.empty? ? nil : property.choices
    placeholder = property.description.present? && property.description.include?("||") ? property.description.split("||")[0] : property.name
    result = "<div class=\"form-group #{base_name.gsub("[]]","]")}\" id=\"form-group\">\n"
    result += label_tag "prop_#{property.id}", property.name, class: label_class
    result += "\n<div class=\"#{control_class}\">\n"
    result += hidden_field_tag(field_name(base_name, "value_holder_id"), property.value_holder_id.nil? ? "new" : property.value_holder_id) + "\n"
    result += hidden_field_tag(field_name(base_name, "value_id"), property.value_id.nil? ? "new" : property.value_id) + "\n"
    if !collection_mapped.nil?
      result += select_tag(field_name(base_name, "data"), collection_mapped, {}, {class: "form-control", id: field_name(base_name, "data")})
    else
      result += text_field_tag(field_name(base_name, "data"), property.value_data, class: "form-control", id: field_name(base_name, "data"), placeholder: placeholder)
    end
    result += "\n<span class=\"help-block small\" style=\"display:inline;\">#{help_text}</span>\n" unless help_text.nil?
    result += "\n</div>\n</div>\n"
  end
  
  def field_name(prefix, suffix = "")
    prefix.gsub("]]","#{suffix}]]")
  end
  
  def audit_link(audit)
    audit_id = audit.auditable_id
    case audit.auditable_type
    when "Company"
      edit_company_path(audit.target)
    when "Site"
      edit_site_path(audit.target, active_panel: "site_basics_panel")
    when "Zone"
      edit_site_path(audit.target.site, active_panel: "influent_panel_1")
    when "Basin"
      edit_site_path(audit.target.zone.site, active_panel: "basin_info_panel0")
    when "Property"
      if audit.user.present?
        edit_site_path(audit.user.company.sites.first)
      else
        "#"
      end
    end
  end

end
