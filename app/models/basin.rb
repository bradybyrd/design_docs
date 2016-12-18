class Basin < ActiveRecord::Base
  enum basin_type: [:cylindrical, :rectangular, :lagoon, :other]
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable
  
  belongs_to :zone
  
  delegate :site, to: :zone
  
  before_save :set_modified

  scope :ordered, -> { order("archive_number DESC, zone_id, name")}
  
  DISPLAY_UNITS = {length: "meters||feet", width: "meters|feet", depth: "meters||feet", diameter: "meters||feet", volume: "m<sup>3</sup>||ft<sup>3</sup>", surface_area: "m<sup>2</sup>||ft<sup>2</sup>"}

  def display_units(field_name)
    DISPLAY_UNITS[field_name]
  end
  
  def zone_name
    self.zone.name
  end
end
