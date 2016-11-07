class Property < ActiveRecord::Base
  include Archivable
  HOLDER_MODELS = ["Basin", "Company", "Site", "SystemSetting", "Zone"]
  has_many :property_values, dependent: :destroy

  validates :name,
            uniqueness: { scope: :holder_model }

  before_save :set_modified
  
  scope :settings, -> { where("holder_model = 'SystemSetting'") }
  scope :ordered, -> { order("archive_number DESC, holder_model, position, name")}
  scope :for_model, -> (model) { where("holder_model = ?", model) }
  
  def self.for_input(holder, categories = [])
    result = self.unarchived.for_model(holder)
    result = result.where("category IN (?)", categories.join(",")) if categories.size > 0
    result.ordered
  end
end
