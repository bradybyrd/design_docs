module PropertyMethods
  def properties
    Property.where("holder_model = '#{self.class.to_s}' AND archived_at is NULL").order("properties.name")
  end
  
  def current_property_values
    sql =<<-END
    select p.id, p.name, pv.data, pv.archive_number from properties p 
    left join (select * from property_values where holder_id = #{self.id} and archive_number is NULL) pv on p.id = pv.property_id
    where p.holder_model = '#{self.class.to_s}' and p.archive_number is NULL
    END
  
    Property.find_by_sql(sql)
  end

  def all_property_values
    sql =<<-END
    select p.id, p.name, pv.data, pv.archive_number from properties p 
    left join (select * from property_values where holder_id = #{self.id}) pv on p.id = pv.property_id
    where p.holder_model = '#{self.class.to_s}'
    END
  
    Property.find_by_sql(sql)
  end
  
  def update_properties(prop_params)
    logger.info "Updating Properties: #{prop_params}"
    updater = []
    (1..50).each{|l| updater << {} }
    prop_params.each do |key, val|
      idx = key.split("_")[-1]
      updater[idx.to_i][key.gsub("_#{idx}", "")] = val
    end
    updater.each do |prop_hash|
      if prop_hash.has_key?("select_property_id") && prop_hash.has_key?("new_name") && prop_hash["new_name"].present?
        add_property(prop_hash)
      elsif prop_hash.has_key?("select_property_id") && prop_hash["select_property_id"].to_i > 0
        add_property_value(prop_hash)
      elsif prop_hash.has_key?("property_value_id") && prop_hash["property_value_id"] == "new_id"
        add_property_value(prop_hash)
      elsif prop_hash["data"].present?
        add_property_value(prop_hash)
      end
    end
  end
  
  def add_property(prop_hash)
    return nil if prop_hash["new_name"].length < 2
    prop = Property.create({name: prop_hash["new_name"], holder_model: self.class.to_s, created_by_id: User.current_user.id})
    logger.info "Adding new property: #{prop.id} - #{prop_hash["new_name"]}: #{prop_hash["data"]}"
    add_property_value(prop_hash, prop)
  end
  
  def add_property_value(prop_hash, property = nil)
    property = Property.find_by_id(prop_hash["select_property_id"]) if property.nil? && prop_hash.has_key?("select_property_id")
    property = Property.find_by_id(prop_hash["property_id"]) if property.nil?
    logger.info "Adding new property_value: #{property.id} - #{prop_hash["data"]}"
    property.property_values.create({holder_id: self.id, data: prop_hash["data"], created_by_id: User.current_user.id})
  end
end