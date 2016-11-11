class AddAaaToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :archive_number, :string
    add_column :companies, :archived_at, :datetime
  end
end
