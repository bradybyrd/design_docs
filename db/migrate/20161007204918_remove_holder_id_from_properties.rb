class RemoveHolderIdFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :holder_id
  end
end
