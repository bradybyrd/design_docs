class Property < ActiveRecord::Base
  include Archivable
  HOLDER_MODELS = ["Basin", "Company", "Site", "SystemSetting", "Zone"]
  has_many :property_values, dependent: :destroy
  accepts_nested_attributes_for :property_values
  attr_accessor :value_holder_id, :value_id, :value_data
  
  validates :name,
            uniqueness: { scope: :holder_model }

  before_save :set_modified
  
  scope :settings, -> { where("holder_model = 'SystemSetting'") }
  scope :ordered, -> { order("archive_number DESC, holder_model, position, name")}
  scope :for_holder, -> (holder) { where("holder_model = ?", holder) }
  
  serialize :choices, Array
  
  def current_value_for(holder_id = value_holder_id)
    result = self.property_values.for(holder_id)
    result.empty? ? prop.property_value.new(holder_id: holder_id, updated_by_id: User.current_user.id) : result.first
  end

  def help_text(holder_record = nil)
    return "" if tip.nil?
    tips = tip.split("||")
    holder_record = holder_model.constantize.find_by_id(value_holder_id) if value_holder_id.present? && holder_record.nil?
    return tips[0] unless value_holder_id.present?
    metric = site(holder_record).metric?
    if tips.size < 2
      return tips[0]
    else
      return metric ? tips[0] : tips[1]
    end
  end
  
  def site(holder_record = nil)
    return nil if value_holder_id.nil? && holder_record.nil?
    holder_record = holder_model.constantize.find_by_id(value_holder_id) if value_holder_id.present? && holder_record.nil?
    result = if holder_model == "Site"
      holder_record
    elsif holder_model == "Zone"
      holder_record.site
    elsif holder_model == "Basin"
      holder_record.zone.site
    else
      nil
    end
    result
  end
    
end
