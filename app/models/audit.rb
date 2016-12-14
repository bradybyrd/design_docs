class Audit < ActiveRecord::Base

  belongs_to :user
  scope :recent_x, -> (since_days = 30){ where("created_at > ?", since_days.days.ago).order("created_at DESC")}
  
  def target
    auditable_type.constantize.find_by_id(auditable_id)
  end
  
end