class Audit < ActiveRecord::Base

  belongs_to :user
  scope :recent_x, -> (since_days = 30){ where("audits.created_at > ?", since_days.days.ago).order("audits.created_at DESC")}
  
  def target
    auditable_type.constantize.find_by_id(auditable_id)
  end
  
  def self.for_user(user)
    if !user.company.master?
      self.joins(:user).where("users.company_id = ?", user.company_id)
    else
      self.all
    end
  end
  
end