class PropertyValue < ActiveRecord::Base
  include Archivable
  
  belongs_to :property
  before_save :expire_current_values
  
  scope :current, -> { where(archived_at: nil) }
  scope :for, -> (holder_id) { where("archived_at is NULL AND holder_id = '?'", holder_id ) }
  scope :ordered, -> { order("archive_number DESC, updated_at DESC")}
  
  delegate :holder_model, :to => :property
  
  def holder
    holder_model.constantize.find_by_id(holder_id)
  end
  
  def expire_current_values
    extant = PropertyValue.where("archived_at is NULL AND property_id = #{self.property_id} AND holder_id = #{self.holder_id}")
    logger.info "Archiving current property values [#{extant.map(&:id).join(",")}]" unless extant.nil?
    extant.each{|k| k.archive(archived_by_id: User.current_user) }
  end
  
  def holder_value
    "#{holder_model}-#{holder_id}"
  end
  
  def holder_name
    "#{holder_id}-#{holder.try(:name)}"
  end
  
  def creator
    u = User.find_by_id(created_by_id)
    arch = self.archived? ? '-archived' : ''
    "#{u.nil? ? "unknown" : u.short_name}-#{created_at.to_s(:simple_time)}#{arch}"
  end
end
