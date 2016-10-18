module Archivable
  def self.included(k)
    k.extend ClassMethods
  end
  
  module ClassMethods
    def archived
      where(%Q{#{self.table_name}.archived_at IS NOT NULL AND #{self.table_name}.archive_number IS NOT NULL})
    end
  
    def unarchived
      where(:archived_at => nil, :archive_number => nil)
    end
  end
  
  def archived?
    self.archived_at? && self.archive_number
  end

  def archive(options = {})
    unless self.archived?
      head_archive_number ||= Digest::MD5.hexdigest("#{self.class.name}#{self.id}")
      updater = {
        archived_at: DateTime.now, 
        archive_number: head_archive_number
      }
      updater[:name] = "#{head_archive_number}__#{self.name}" if self.respond_to?(:name)
      options.each{|k,v| updater[k] = v }
      self.update_columns(updater)
    end
  end    

  def unarchive
    if self.archived?
      head_archive_number ||= Digest::MD5.hexdigest("#{self.class.name}#{self.id}")
      updater = {
        archived_at: DateTime.now, 
        archive_number: head_archive_number
      }
      updater[:name] = self.name.gsub("#{head_archive_number}__","") if self.respond_to?(:name)
      self.update_columns(updater)
    end
  end
end
