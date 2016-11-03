class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.text :description
      t.datetime :archived_at
      t.string :archive_number
      t.integer :updated_by_id
      t.integer :site_id

      t.timestamps null: false
    end
  end
end
