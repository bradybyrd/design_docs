class AddPhotoPathToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo_path, :string
  end
end
