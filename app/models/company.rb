class Company < ActiveRecord::Base
  include Archivable
  
  has_many :users
  has_many :sites, dependent: :destroy
  
  validates :name, uniqueness: true
  
  scope :ordered, -> { order("companies.archive_number DESC, companies.name")}
      
end
