class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.integer :site_id
      t.string :report_path
      t.integer :updated_by_id

      t.timestamps null: false
    end
  end
end
