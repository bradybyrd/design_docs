class CreateBasins < ActiveRecord::Migration
  def change
    create_table :basins do |t|
      t.integer :site_id
      t.string :name
      t.integer :basin_type
      t.float :depth
      t.float :width
      t.float :length
      t.float :diameter
      t.float :volume
      t.float :surface_area
      t.float :side_slope_ratio
      t.string :archive_float
      t.datetime :archived_at
      t.integer :updated_by_id
      t.timestamps null: false
    end
  end
end
