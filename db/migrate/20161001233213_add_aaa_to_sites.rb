class AddAaaToSites < ActiveRecord::Migration
  def change
    add_column :sites, :archive_number, :string
    add_column :sites, :archived_at, :datetime
  end
end
