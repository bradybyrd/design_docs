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
  
  def current_value_for(holder_id)
    result = self.property_values.for(holder_id)
    result.empty? ? prop.property_value.new(holder_id: holder_id, updated_by_id: User.current_user.id) : result.first
  end
    
end
