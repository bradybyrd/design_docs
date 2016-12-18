class AddUnitsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :units, :string
  end
end
