class Customer < ActiveRecord::Base
  include Archivable
  
  has_many :users
  has_many :sites
  has_many :properties
end
