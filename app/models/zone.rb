class Zone < ActiveRecord::Base
  include Archivable
  include PropertyMethods
  audited
  acts_as_commentable :public, :private
  
  has_many :basins
  belongs_to :site

  scope :ordered, -> { order("archive_number DESC, name")}

  def modified
    user = User.find_by_id(updated_by_id)
    user.nil? ? "unknown" : "#{user.first_name[0]}#{user.last_name}@#{updated_at.to_s(:simple_time)}"
  end
  
end
