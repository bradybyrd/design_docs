class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.integer :updated_by_id
      t.timestamps null: false
    end
  end
end
