class Basin < ActiveRecord::Base
  include Archivable
  include PropertyMethods
  
  belongs_to :site
  belongs_to :customer, through: :site


  def modified
    user = User.find_by_id(updated_by_id)
    user.nil? ? "unknown" : "#{user.first_name[0]}#{user.last_name}@#{created_at.to_s(:simple_time)}"
  end

end
