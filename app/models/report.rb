class Report < ActiveRecord::Base
  include Archivable

  belongs_to :site
  before_save :set_modified
  
  mount_uploader :report_path, AttachmentUploader
  
  
end
