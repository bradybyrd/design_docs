class AddMasterToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :master, :boolean
  end
end
