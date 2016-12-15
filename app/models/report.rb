class Report < ActiveRecord::Base
  include Archivable

  belongs_to :site
  before_save :set_modified
  
  mount_uploader :report_path, AttachmentUploader
  
  scope :ordered, -> { includes(:site).order("sites.name, reports.created_at DESC")}
end
