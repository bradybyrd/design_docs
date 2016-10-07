class AddAaaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :archive_number, :string
    add_column :users, :archived_at, :datetime
  end
end
