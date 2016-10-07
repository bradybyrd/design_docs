class AddCreatorIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :creator_id, :string
  end
end
