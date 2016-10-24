class AddHolderIdAndCreatorIdToPropertyValues < ActiveRecord::Migration
  def change
    add_column :property_values, :holder_id, :integer
    add_column :property_values, :created_by_id, :integer
  end
end
