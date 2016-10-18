class User < ActiveRecord::Base
  enum role: [:reporter, :user, :global, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  include Archivable
  
  after_initialize :set_default_role, :if => :new_record?

  def self.current_user
    @current_user || User.new(email: 'admin@us.com', first_name: 'admin', last_name: 'User')
  end
  
  def self.current_user=(cur_user)
    @current_user = cur_user
  end
  
  def set_default_role
    self.role ||= :reporter
  end
  
  def short_name
    "#{first_name[0]}#{last_name}"
  end
end
