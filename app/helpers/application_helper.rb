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
end
