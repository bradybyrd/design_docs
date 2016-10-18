class AddArchiveNumberAndArchivedAtToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :archive_number, :string
    add_column :properties, :archived_at, :datetime
  end
end
