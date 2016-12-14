class Report < ActiveRecord::Base
  belongs_to :site
  
  mount_uploader :report_path, AttachmentUploader
  
  
end
