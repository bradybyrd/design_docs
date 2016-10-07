class RemoveHolderIdFromProperties < ActiveRecord::Migration
  def change
    delete_column :properties, :holder_id
  end
end
