class CreatePropertyValues < ActiveRecord::Migration
  def change
    create_table :property_values do |t|
      t.integer :property_id
      t.string :data
      t.datetime :archived_at
      t.integer :archived_by_id
      t.string :archive_number
      t.timestamps null: false
    end
  end
end
