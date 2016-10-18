class Site < ActiveRecord::Base
  include Archivable
  
  STATES = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  
  belongs_to :customer
  
  def properties
    Property.where("holder_model = 'Site' AND archived_at is NULL").order("properties.name")
  end
  
  def current_property_values
    #Property.joins("left join property_values on property_values.property_id = properties.id").where("holder_model = 'Site' and property_values.holder_id = ?", self.id)
    #PropertyValue.unarchived.joins(:property).where("property_id in (select id from properties where properties.holder_model = 'Site' and holder_id = #{self.id})")
    sql =<<-END
    select p.id, p.name, pv.data, pv.archive_number from properties p left join (select * from property_values where holder_id = 1) pv on p.id = pv.property_id
    where p.holder_model = 'Site'
    END
  
    Property.find_by_sql(sql)
  end

  def modified
    user = User.find_by_id(updated_by_id)
    user.nil? ? "unknown" : "#{user.first_name[0]}#{user.last_name}@#{created_at.to_s(:simple_time)}"
  end
  
end
