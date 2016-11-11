class Company < ActiveRecord::Base
  include Archivable
  
  has_many :users
  has_many :sites
end
