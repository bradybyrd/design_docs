class Basin < ActiveRecord::Base
  enum basin_type: [:cylindrical, :rectangular, :lagoon, :other]
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable :public, :private
  
  belongs_to :zone
  scope :ordered, -> { order("archive_number DESC, zone_id, name")}

  def modified
    user = User.find_by_id(updated_by_id)
    user.nil? ? "unknown" : "#{user.first_name[0]}#{user.last_name}@#{updated_at.to_s(:simple_time)}"
  end

end
