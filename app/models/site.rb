class Site < ActiveRecord::Base
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable
  before_save :set_modified
  
  STATES = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)
  UNITS = %w(Metric English)
  
  validates :name, presence: true
  validates :company_id, presence: true
  
  belongs_to :company
  has_many :zones, dependent: :destroy
  has_many :reports

  scope :ordered, -> { order("archive_number DESC, sites.name")}
  
  accepts_nested_attributes_for :reports, :allow_destroy => true
  
  def basins(zone_id = nil)
    if zone_id.nil? && self.zones.empty?
      result = Basin.where("zone_id = -2")
    else
      result = Basin.where("zone_id IN (#{self.zones.map(&:id).join(",")})") if zone_id.nil?
      result = Basin.where("zone_id = ?", zone_id) if !zone_id.nil?
    end
    result.unarchived
  end
  
  def spreadsheet_data
    result = []
    [:units, :name, :city, :state, :address1, :address2, :gps].each do |it|
      result << {id: self.id, holder: 'Site', category: 'Basics', field: it.to_s, data: self.send(it)}
    end
    categories = self.properties(false).select(:category).distinct.map(&:category) rescue []
    self.properties_for_input(categories).each do |prop|
      result << {id: prop.id, holder: 'Site', category: prop.category, field: prop.name, data: prop.value_data}
    end
    self.zones.unarchived.each_with_index do |zone, idx|
      categories = zone.properties(false).select(:category).distinct.map(&:category) rescue []
      result << {id: zone.id, holder: "Zone_#{idx}", category: '', field: "Zone Name", data: zone.name}
    
      zone.properties_for_input(categories).each do |prop|
        result << {id: prop.id, holder: "Zone_#{idx}", category: prop.category, field: prop.name, data: prop.value_data}
      end
      zone.basins.unarchived.each_with_index do |basin, cnt|
        [:name, :zone_name, :basin_type, :depth, :width, :length, :surface_area, :volume, :side_slope_ratio].each do |it|
          result << {id: basin.id, holder: "Basin_#{cnt}", category: 'Basics', field: it.to_s, data: basin.send(it)}
        end
        categories = basin.properties(false).select(:category).distinct.map(&:category) rescue []
        basin.properties_for_input(categories).each do |prop|
          result << {id: prop.id, holder: "Basin_#{cnt}", category: prop.category, field: prop.name, data: prop.value_data}
        end
      end
    end
    result
  end
  
  def metric?
    self.units = "metric" if self.units.nil?
    self.units.downcase == "metric"
  end
  
  private
  
  
end
