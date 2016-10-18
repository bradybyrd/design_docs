class Property < ActiveRecord::Base
  include Archivable
  
  has_many :property_values, dependent: :destroy

  validates :name,
            uniqueness: { scope: :holder_model }
            
  
  scope :settings, -> { where(holder_model: 'SystemSetting') }
  scope :ordered, -> { order("archive_number DESC, holder_model, name")}
  
  def created
    user = User.find_by_id(created_by_id)
    user.nil? ? "unknown" : "#{user.first_name[0]}#{user.last_name}@#{created_at.to_s(:simple_time)}"
  end
  
end
