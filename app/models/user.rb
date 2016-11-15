class User < ActiveRecord::Base
  require 'base64'
  enum role: [:reporter, :user, :global, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  include Archivable
  
  mount_uploader :attachment, AttachmentUploader
  
  belongs_to :company
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
  
  def picture_url
    result = "#"
    if attachment.present?
      result = attachment.file.file.gsub(Rails.root.to_s,"").gsub("/public/","")
    end
    result
  end
  
  def auth_token
    Base64.encode64("#{encrypted_password}#{last_name}").gsub("\n","").slice(0..63)
  end
  
end
