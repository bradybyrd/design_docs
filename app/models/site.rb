class Site < ActiveRecord::Base
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable :public, :private
  
  STATES = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  has_many :zones
  belongs_to :customer

  scope :ordered, -> { order("archive_number DESC, name")}

  def modified
    user = User.find_by_id(updated_by_id)
    user.nil? ? "unknown" : "#{user.first_name[0]}#{user.last_name}@#{updated_at.to_s(:simple_time)}"
  end
  
  def basins(zone_id = nil)
    if zone_id.nil? && self.zones.empty?
      result = Basin.where("zone_id = -2")
    else
      result = Basin.where("zone_id IN (?)", self.zones.map(&:id).join(",")) if zone_id.nil?
      result = Basin.where("zone_id = ?", zone_id) if !zone_id.nil?
    end
    result
  end
end
