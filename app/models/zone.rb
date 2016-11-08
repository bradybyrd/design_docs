class Zone < ActiveRecord::Base
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable
  
  has_many :basins
  belongs_to :site

  before_save :set_modified

  scope :ordered, -> { order("archive_number DESC, name")}
  
end
