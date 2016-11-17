class Company < ActiveRecord::Base
  include Archivable
  
  has_many :users
  has_many :sites
  
  validates :name, unique: true
end
