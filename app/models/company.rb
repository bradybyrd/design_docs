class Company < ActiveRecord::Base
  include Archivable
  
  has_many :users
  has_many :sites
  
  validates :name, uniqueness: true
  
  scope :ordered, -> { order("companies.archive_number DESC, companies.name")}
  
      
end
