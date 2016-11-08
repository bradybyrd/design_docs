class Basin < ActiveRecord::Base
  enum basin_type: [:cylindrical, :rectangular, :lagoon, :other]
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable
  
  belongs_to :zone
  
  before_save :set_modified

  scope :ordered, -> { order("archive_number DESC, zone_id, name")}

end
